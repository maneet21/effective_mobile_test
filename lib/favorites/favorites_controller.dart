import 'package:effective_mobile_russia_test/effective_mobile_russia_test_provider.dart';
import 'package:effective_mobile_russia_test/favorites/favorites_model.dart';
import 'package:effective_mobile_russia_test/favorites/favorites_view.dart';
import 'package:effective_mobile_russia_test/helpers/globals.dart';
import 'package:effective_mobile_russia_test/helpers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesController extends StatefulWidget {
  const FavoritesController({super.key});

  @override
  State<FavoritesController> createState() => _FavoritesControllerState();

  viewInit(FavoritesView widget, BuildContext context) async {
    currentScreen = 'Main View';

    final effectiveMobileRussiaTestProvider =
        Provider.of<EffectiveMobileRussiaTestProvider>(context, listen: false);

    await StorageManager().results('rickAndMortyCharactersFavorites').then((
      value,
    ) {
      widget.favoritesViewData.favoriteRickAndMortyCharacter = value;
    });

    effectiveMobileRussiaTestProvider.refresh('Favorites List', 'Main View');
  }

  String cellInformation(FavoritesView widget, int cellIndex, int index) {
    switch (cellIndex) {
      case 1:
        {
          return 'Status: ${widget.favoritesViewData.favoriteRickAndMortyCharacter[index].status}';
        }

      case 2:
        {
          return 'Species: ${widget.favoritesViewData.favoriteRickAndMortyCharacter[index].species}';
        }

      case 3:
        {
          return 'Gender: ${widget.favoritesViewData.favoriteRickAndMortyCharacter[index].gender}';
        }

      default:
        {
          return '';
        }
    }
  }

  Future<void> showMyDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(children: [Text('Item Deleted')]),
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

class _FavoritesControllerState extends State<FavoritesController> {
  FavoritesModel favoritesViewData = FavoritesModel(
    favoriteRickAndMortyCharacter: [],
  );

  @override
  Widget build(BuildContext context) {
    return FavoritesView(
      favoritesController: FavoritesController(),
      favoritesViewData: favoritesViewData,
    );
  }
}
