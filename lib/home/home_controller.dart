import 'package:effective_mobile_russia_test/effective_mobile_russia_test_provider.dart';
import 'package:effective_mobile_russia_test/helpers/globals.dart';
import 'package:effective_mobile_russia_test/helpers/network_manager.dart';
import 'package:effective_mobile_russia_test/helpers/network_monitor.dart';
import 'package:effective_mobile_russia_test/helpers/storage_manager.dart';
import 'package:effective_mobile_russia_test/home/home_model.dart';
import 'package:effective_mobile_russia_test/home/home_view.dart';
import 'package:effective_mobile_russia_test/models/rick_and_morty_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class HomeController extends StatefulWidget {
  const HomeController({super.key});

  @override
  State<HomeController> createState() => _HomeControllerState();

  viewInit(HomeView widget, BuildContext context) async {
    currentScreen = 'Main View';

    final effectiveMobileRussiaTestProvider =
        Provider.of<EffectiveMobileRussiaTestProvider>(context, listen: false);

    internetCheck().then((value) async {
      widget.homeViewData.noInternet = value;

      if (widget.homeViewData.noInternet) {
        /// from storage
        StorageManager().results('rickAndMortyCharacters').then((value) {



          widget.homeViewData.rickAndMortyCharacters = value;
        });

        getPrefs().then((v) {
          int pagesSaved = v.getInt('pages saved') ?? 0;

          widget.homeViewData.pagesLoaded = pagesSaved;
        });

        /// refreshing
        effectiveMobileRussiaTestProvider.refresh('Home List', 'Main View');
        effectiveMobileRussiaTestProvider.isLoading(false, 'Main View');
      } else {
        /// from internet
        await NetworkManager()
            .getRickAndMortyCharacters(widget.homeViewData.pagesLoaded)
            .then((v) async {
              widget.homeViewData.rickAndMortyCharacters.addAll(v);

              await getFavorites(widget, context.mounted ? context : context);
            });

        widget.homeViewData.pagesLoaded += 1;

        /// refreshing
        effectiveMobileRussiaTestProvider.refresh('Home List', 'Main View');
        effectiveMobileRussiaTestProvider.isLoading(false, 'Main View');
      }
    });
  }

  Future<void> getFavorites(HomeView widget, BuildContext context) async {
    await StorageManager().results('rickAndMortyCharactersFavorites').then((
      value,
    ) {
      widget.homeViewData.favoriteRickAndMortyCharacters = value;
    });
  }

  bool checkAlreadyInFavorites(HomeView widget, RickAndMortyCharacters item) {
    if (widget.homeViewData.favoriteRickAndMortyCharacters
        .map((v) => v.name)
        .toList()
        .contains(item.name)) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> internetCheck() async {
    ConnectivityResult result = ConnectivityResult.none;
    bool noInternet = false;

    await NetworkMonitor().initConnectivity().then((values) {
      result = values.first;

      if (result.name == 'none') {
        noInternet = true;
      } else {
        noInternet = false;
      }
    });

    return noInternet;
  }

  String cellInformation(HomeView widget, int cellIndex, int index) {
    switch (cellIndex) {
      case 1:
        {
          return 'Status: ${widget.homeViewData.rickAndMortyCharacters[index].status}';
        }

      case 2:
        {
          return 'Species: ${widget.homeViewData.rickAndMortyCharacters[index].species}';
        }

      case 3:
        {
          return 'Gender: ${widget.homeViewData.rickAndMortyCharacters[index].gender}';
        }

      default:
        {
          return '';
        }
    }
  }

  Future<SharedPreferences> getPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs;
  }

  Future<void> showMyDialog(bool addedToFavorites, BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Text(
                  addedToFavorites
                      ? 'Item added to favorites'
                      : 'This item is already in favorites.',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}

class _HomeControllerState extends State<HomeController> {
  HomeModel homeViewData = HomeModel(
    rickAndMortyCharacters: [],
    loading: false,
    autoScrollController: AutoScrollController(),
    noInternet: false,
    pagesLoaded: 1,
    favoriteRickAndMortyCharacters: [],
    newlyAddedToFavorites: RickAndMortyCharacters(
      image: '',
      name: '',
      status: '',
      gender: '',
      species: '',
    ),
  );

  @override
  Widget build(BuildContext context) {
    return HomeView(
      homeViewData: homeViewData,
      homeController: HomeController(),
    );
  }
}
