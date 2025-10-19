import 'package:uuid/uuid.dart';

class Endroit {
  final String id;
  final String nom;
  final String description;
  final String? image;

  static const uuid = Uuid();

  //everytime you create an endroit object
  //give it a uuid randomly as well a name "nom"
  Endroit({required this.nom, required this.description, this.image})
    : id = uuid.v4();
}
