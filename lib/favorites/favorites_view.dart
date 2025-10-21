import 'package:cached_network_image/cached_network_image.dart';
import 'package:effective_mobile_russia_test/effective_mobile_russia_test_provider.dart';
import 'package:effective_mobile_russia_test/favorites/favorites_controller.dart';
import 'package:effective_mobile_russia_test/favorites/favorites_model.dart';
import 'package:effective_mobile_russia_test/helpers/storage_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavoritesView extends StatefulWidget {
  final FavoritesController favoritesController;
  final FavoritesModel favoritesViewData;
  const FavoritesView({
    super.key,
    required this.favoritesController,
    required this.favoritesViewData,
  });

  @override
  State<FavoritesView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<FavoritesView> {
  @override
  void initState() {
    super.initState();

    widget.favoritesController.viewInit(widget, context);
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;

    return Container(
      color: Colors.white,
      child: Consumer<EffectiveMobileRussiaTestProvider>(
        builder:
            (
              context,
              EffectiveMobileRussiaTestProvider
              effectiveMobileRussiaTestProvider,
              child,
            ) => ListView.separated(
              itemCount:
                  effectiveMobileRussiaTestProvider.refreshUI ==
                      'Favorites List'
                  ? widget
                        .favoritesViewData
                        .favoriteRickAndMortyCharacter
                        .length
                  : 0,
              itemBuilder: (context, index) {
                return Container(
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
                                      .favoritesViewData
                                      .favoriteRickAndMortyCharacter[index]
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
                                                border: Border.all(width: 0.5),
                                              ),
                                              width: deviceWidth / 4,
                                              child: Center(
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  'Name: ${widget.favoritesViewData.favoriteRickAndMortyCharacter[index].name}',
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
                                                      StorageManager()
                                                          .delete(
                                                            widget
                                                                .favoritesViewData
                                                                .favoriteRickAndMortyCharacter[index],
                                                            'rickAndMortyCharactersFavorites',
                                                          )
                                                          .then((v) {
                                                            widget
                                                                .favoritesController
                                                                .showMyDialog(
                                                                  context.mounted
                                                                      ? context
                                                                      : context,
                                                                )
                                                                .then((
                                                                  v1,
                                                                ) async {
                                                                  await StorageManager()
                                                                      .results(
                                                                        'rickAndMortyCharactersFavorites',
                                                                      )
                                                                      .then((
                                                                        value,
                                                                      ) {
                                                                        widget.favoritesViewData.favoriteRickAndMortyCharacter =
                                                                            value;

                                                                        effectiveMobileRussiaTestProvider.refresh(
                                                                          'Favorites List',
                                                                          'Main View',
                                                                        );
                                                                      });
                                                                });
                                                          });
                                                    },
                                                    icon: Icon(Icons.delete),
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
                                          border: Border.all(),
                                        ),
                                        height: 62.5,
                                        child: Center(
                                          child: Text(
                                            textAlign: TextAlign.center,
                                            widget.favoritesController
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
                );
              },
              separatorBuilder: (context, index) {
                return Container(height: 5);
              },
            ),
      ),
    );
  }
}
