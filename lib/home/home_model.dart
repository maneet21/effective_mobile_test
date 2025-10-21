import 'package:scroll_to_index/scroll_to_index.dart';
import '../models/rick_and_morty_model.dart';

class HomeModel {
  List<RickAndMortyCharacters> rickAndMortyCharacters;
  bool loading;
  AutoScrollController autoScrollController;

  List<RickAndMortyCharacters> favoriteRickAndMortyCharacters;
  RickAndMortyCharacters newlyAddedToFavorites;

  bool noInternet;
  int pagesLoaded;

  HomeModel({
    required this.rickAndMortyCharacters,
    required this.loading,

    required this.autoScrollController,
    required this.noInternet,
    required this.pagesLoaded,
    required this.favoriteRickAndMortyCharacters,
    required this.newlyAddedToFavorites,
  });
}
