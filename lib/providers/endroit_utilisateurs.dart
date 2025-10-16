import 'dart:io';
import 'package:flutter_application_3/modele/endroit.dart';
import 'package:flutter_riverpod/legacy.dart';

class EndroitUtilisateurs extends StateNotifier<List<Endroit>> {
  EndroitUtilisateurs() : super(const []);

  void ajoutendroit(String name, String description, File? image) {
    final newPlace = Endroit(
      nom: name,
      description: description,
      image: image != null ? image.path : null,
    );

    state = [newPlace, ...state];
  }

  void removeAt(int index) {
    final updatedList = [...state];
    updatedList.removeAt(index);
    state = updatedList;
  }
}

final endroitsprovider =
    StateNotifierProvider<EndroitUtilisateurs, List<Endroit>>(
      (ref) => EndroitUtilisateurs(),
    );
