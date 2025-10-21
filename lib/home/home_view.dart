import 'package:effective_mobile_russia_test/effective_mobile_russia_test_provider.dart';
import 'package:effective_mobile_russia_test/helpers/storage_manager.dart';
import 'package:effective_mobile_russia_test/home/home_controller.dart';
import 'package:effective_mobile_russia_test/home/home_model.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import '../helpers/network_manager.dart';

class HomeView extends StatefulWidget {
  final HomeController homeController;
  final HomeModel homeViewData;
  const HomeView({
    super.key,
    required this.homeViewData,
    required this.homeController,
  });

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();

    widget.homeController.viewInit(widget, context);

    widget.homeViewData.autoScrollController.addListener(scrollListener);
  }

  void scrollListener() async {
    final effectiveMobileRussiaTestProvider =
        Provider.of<EffectiveMobileRussiaTestProvider>(context, listen: false);

    if (widget.homeViewData.autoScrollController.position.pixels ==
        widget.homeViewData.autoScrollController.position.maxScrollExtent && !widget.homeViewData.noInternet) {
      effectiveMobileRussiaTestProvider.isLoading(true, 'Main View');

      await NetworkManager()
          .getRickAndMortyCharacters(widget.homeViewData.pagesLoaded + 1)
          .then((v) async {
            widget.homeViewData.rickAndMortyCharacters.addAll(v);
          });

      widget.homeViewData.pagesLoaded += 1;

      final prefs = await widget.homeController.getPrefs();

      prefs.setInt('pages saved', widget.homeViewData.pagesLoaded);

      /// refreshing
      await effectiveMobileRussiaTestProvider.refresh('Home List', 'Main View');
      await effectiveMobileRussiaTestProvider.isLoading(false, 'Main View');

      widget.homeViewData.autoScrollController.scrollToIndex(
        widget.homeViewData.rickAndMortyCharacters.length - 20,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        Consumer<EffectiveMobileRussiaTestProvider>(
          builder:
              (
                context,
                EffectiveMobileRussiaTestProvider
                effectiveMobileRussiaTestProvider,
                child,
              ) => Container(
                color: Colors.white,
                child: ListView.separated(
                  controller: widget.homeViewData.autoScrollController,

                  itemCount:
                      effectiveMobileRussiaTestProvider.refreshUI == 'Home List'
                      ? widget.homeViewData.rickAndMortyCharacters.length
                      : 0,
                  itemBuilder: (context, index) {
                    return AutoScrollTag(
                      key: ValueKey(index),
                      controller: widget.homeViewData.autoScrollController,
                      index: index,
                      child: Container(
                        height: 250,
                        decoration: BoxDecoration(color: Colors.white),
                        child: Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(width: 0.5),
                              ),
                              width: deviceWidth / 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                    child: Container(
                                      color: Colors.grey,
                                      child: CachedNetworkImage(
                                        imageUrl: widget
                                            .homeViewData
                                            .rickAndMortyCharacters[index]
                                            .image,
                                        fit: BoxFit.fitHeight,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: 4,
                                        itemBuilder: (context, cellIndex) {
                                          if (cellIndex == 0) {
                                            return SizedBox(
                                              height: 62.5,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 0.5,
                                                      ),
                                                    ),
                                                    width: deviceWidth / 4,
                                                    child: Center(
                                                      child: Text(
                                                        textAlign:
                                                            TextAlign.center,
                                                        'Name: ${widget.homeViewData.rickAndMortyCharacters[index].name}',
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 0.5,
                                                        ),
                                                      ),
                                                      child: Center(
                                                        child: IconButton(
                                                          onPressed: () {
                                                            if (widget
                                                                .homeController
                                                                .checkAlreadyInFavorites(
                                                                  widget,
                                                                  widget
                                                                      .homeViewData
                                                                      .rickAndMortyCharacters[index],
                                                                )) {
                                                              widget
                                                                  .homeController
                                                                  .showMyDialog(
                                                                    false,
                                                                    context,
                                                                  );
                                                            } else {
                                                              StorageManager()
                                                                  .insertResults(
                                                                    widget
                                                                        .homeViewData
                                                                        .rickAndMortyCharacters[index],
                                                                    'rickAndMortyCharactersFavorites',
                                                                  )
                                                                  .then((v) {
                                                                    widget
                                                                        .homeController
                                                                        .showMyDialog(
                                                                          true,
                                                                          context.mounted
                                                                              ? context
                                                                              : context,
                                                                        )
                                                                        .then((
                                                                          v1,
                                                                        ) {
                                                                          widget
                                                                              .homeViewData
                                                                              .newlyAddedToFavorites = widget
                                                                              .homeViewData
                                                                              .rickAndMortyCharacters[index];

                                                                          effectiveMobileRussiaTestProvider.refresh(
                                                                            'Home List',
                                                                            'Main View',
                                                                          );
                                                                        });
                                                                  });
                                                            }
                                                          },
                                                          icon:
                                                              widget.homeController
                                                                      .checkAlreadyInFavorites(
                                                                        widget,
                                                                        widget
                                                                            .homeViewData
                                                                            .rickAndMortyCharacters[index],
                                                                      ) ||
                                                                  (effectiveMobileRussiaTestProvider
                                                                              .refreshUI ==
                                                                          'Home List' &&
                                                                      widget.homeViewData.newlyAddedToFavorites ==
                                                                          widget
                                                                              .homeViewData
                                                                              .rickAndMortyCharacters[index])
                                                              ? Icon(Icons.star)
                                                              : Icon(
                                                                  Icons
                                                                      .star_border,
                                                                ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(width: 0.5),
                                              ),
                                              height: 62.5,

                                              child: Center(
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  widget.homeController
                                                      .cellInformation(
                                                        widget,
                                                        cellIndex,
                                                        index,
                                                      ),
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(height: 5);
                  },
                ),
              ),
        ),
        Consumer<EffectiveMobileRussiaTestProvider>(
          builder:
              (
                context,
                EffectiveMobileRussiaTestProvider
                effectiveMobileRussiaTestProvider,
                child,
              ) => effectiveMobileRussiaTestProvider.activityIndicatorLoading
              ? Center(
                  child: Container(
                    width: 50,
                    height: 50,
                    color: Colors.white,
                    child: CircularProgressIndicator(),
                  ),
                )
              : Text(''),
        ),
      ],
    );
  }
}
