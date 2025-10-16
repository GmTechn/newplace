import 'package:riverpod/legacy.dart';

import 'package:flutter_application_3/modele/endroit.dart';

class EndroitUtilisateurs extends StateNotifier<List<Endroit>> {
  //there are no user at first
  //so empty constructor
  EndroitUtilisateurs() : super(const []);

  //to add a new place with its name
  void ajoutendroit(String name, String description) {
    //when ajout endroit is called
    //the parameter name is passed and
    //an object is create with that name

    final newPlace = Endroit(nom: name, description: description);

    //adding a new place to the list of places
    state = [newPlace, ...state];
  }
}

//creating a global provider that
//can share data accross pages

final endroitsprovider =
    //this notifier provides a list of places objects
    //so en gros it takes as parametters a class of endroits utilisateurs
    //which is a list of endroits : Endroit object
    StateNotifierProvider<EndroitUtilisateurs, List<Endroit>>(
      (ref) => EndroitUtilisateurs(),
    );
