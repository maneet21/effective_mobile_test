import 'dart:convert';
import 'package:effective_mobile_russia_test/helpers/storage_manager.dart';
import 'package:effective_mobile_russia_test/models/rick_and_morty_model.dart';
import 'package:http/http.dart';

class NetworkManager {
  Future<List<RickAndMortyCharacters>> getRickAndMortyCharacters(
    int page,
  ) async {
    List<RickAndMortyCharacters> rickAndMortyCharacters = [];

    final url = Uri.parse(
      'https://rickandmortyapi.com/api/character/?page=$page',
    );

    try {
      final response = await get(url);

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);

        final items = RickAndMortyBaseModel.fromJson(jsonData);

        final storageResults = await StorageManager().results(
          'rickAndMortyCharacters',
        );

        for (var i in items.rickAndMortyCharacters) {
          if (!storageResults.contains(i)) {
            StorageManager().insertResults(i, 'rickAndMortyCharacters');
          }
        }

        rickAndMortyCharacters = items.rickAndMortyCharacters;
      }
    } catch (e) {
      //
    }
    return rickAndMortyCharacters;
  }
}
