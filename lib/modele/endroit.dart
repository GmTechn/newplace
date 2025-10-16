import 'dart:io';

import 'package:uuid/uuid.dart';

class Endroit {
  final String id;
  final String nom;
  final String description;
  //File? imagepath;

  static const uuid = Uuid();

  //everytime you create an endroit object
  //give it a uuid randomly as well a name "nom"
  Endroit({required this.nom, required this.description}) : id = uuid.v4();
}
