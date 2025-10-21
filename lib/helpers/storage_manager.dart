import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/rick_and_morty_model.dart';

class StorageManager {
  dynamic database(String db) async {
    WidgetsFlutterBinding.ensureInitialized();

    Future<Database> database;

    switch (db) {
      case 'rickAndMortyCharacters':
        {
          database = openDatabase(
            join(await getDatabasesPath(), 'rickAndMortyCharacters.db'),
            onCreate: (db, create) {
              return db.execute(
                'CREATE TABLE results (id INTEGER PRIMARY KEY NOT NULL, image STRING, name STRING, status STRING, species STRING, gender STRING)',
              );
            },
            version: 1,
          );
          return database;
        }

      case 'rickAndMortyCharactersFavorites':
        {
          database = openDatabase(
            join(
              await getDatabasesPath(),
              'rickAndMortyCharactersFavorites.db',
            ),
            onCreate: (db, create) {
              return db.execute(
                'CREATE TABLE results (id INTEGER PRIMARY KEY NOT NULL, image STRING, name STRING, status STRING, species STRING, gender STRING)',
              );
            },
            version: 1,
          );
          return database;
        }
    }
  }

  Future<void> insertResults(RickAndMortyCharacters result, String sDb) async {
    final db = await database(sDb);

    await db.insert(
      'results',
      result.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<RickAndMortyCharacters>> results(String sDb) async {
    final db = await database(sDb);

    final List<Map<String, Object?>> resultMaps = await db.query('results');

    return [
      for (final {
            'image': image as String,
            'name': name as String,
            'status': status as String,
            'gender': gender as String,
            'species': species as String,
          }
          in resultMaps)
        RickAndMortyCharacters(
          image: image,
          name: name,
          status: status,
          gender: gender,
          species: species,
        ),
    ];
  }

  Future<int> delete(RickAndMortyCharacters item, String sDb) async {
    final db = await database(sDb);

    return await db.delete(
      'results',
      where: "name = ?",
      whereArgs: [item.name],
    );
  }
}
