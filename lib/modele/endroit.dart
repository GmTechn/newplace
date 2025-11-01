import 'package:uuid/uuid.dart';

class Endroit {
  final String id;
  final String nom;
  final String description;
  final String? image;

  static const uuid = Uuid();

  //everytime you create an endroit object
  //give it a uuid randomly as well a name "nom"
  Endroit({
    required this.nom,
    required this.description,
    this.image,
    required id,
  }) : id = uuid.v4();

  // Convert an Endroit to a Map for database storage
  Map<String, dynamic> toMap() {
    return {'id': id, 'nom': nom, 'description': description, 'image': image};
  }

  // Convert a Map from database to an Endroit
  factory Endroit.fromMap(Map<String, dynamic> map) {
    return Endroit(
      id: map['id'],
      nom: map['nom'],
      description: map['description'],
      image: map['image'],
    );
  }
}
