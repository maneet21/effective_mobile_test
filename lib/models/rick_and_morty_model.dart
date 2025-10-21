class RickAndMortyBaseModel {
  List<RickAndMortyCharacters> rickAndMortyCharacters;

  RickAndMortyBaseModel({required this.rickAndMortyCharacters});

  RickAndMortyBaseModel.fromJson(Map<String, dynamic> json)
    : rickAndMortyCharacters = List<RickAndMortyCharacters>.from(
        json['results'].map((x) => RickAndMortyCharacters.fromJson(x)),
      );
}

class RickAndMortyCharacters {
  String image;
  String name;
  String status;
  String species;
  String gender;

  RickAndMortyCharacters({
    required this.image,
    required this.name,
    required this.status,
    required this.gender,
    required this.species,
  });

  RickAndMortyCharacters.fromJson(Map<String, dynamic> json)
    : image = json['image'],
      name = json['name'],
      status = json['status'],
      species = json['species'],
      gender = json['gender'];

  Map<String, Object?> toMap() {
    return {
      'image': image,
      'name': name,
      'status': status,
      'species': species,
      'gender': gender,
    };
  }
}
