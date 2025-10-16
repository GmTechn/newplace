import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/providers/endroit_utilisateurs.dart';
import 'package:flutter_application_3/widgets/imageprise.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AjoutEndroit extends ConsumerStatefulWidget {
  const AjoutEndroit({super.key});
  @override
  ConsumerState<AjoutEndroit> createState() => _AjoutEndroitState();
}

class _AjoutEndroitState extends ConsumerState<AjoutEndroit> {
  //place controller
  TextEditingController _placenameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  //file to store image
  File? _imageSelected;

  //enregistrer un endroit saved

  void _enregistreendroit() async {
    final place = _placenameController.text;
    final description = _descriptionController.text;

    if (place.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a place'),
          backgroundColor: Color(0xff94d6ea),
        ),
      );
      return;
    }

    //add place to provider
    ref.read(endroitsprovider.notifier).ajoutendroit(place, description);

    //pop of context, go back to the display list
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //----APPBAR----///
      appBar: AppBar(
        backgroundColor: Color(0xff76abbb),
        title: Text(
          'Add new place',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),

      //--- BODY ----///
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              SizedBox(height: 20),
              //container to display image of the selected place
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1.5, color: Color(0xff6896a4)),
                  borderRadius: BorderRadius.circular(12),
                ),
                height: 200,
                width: double.infinity,
                child: ImagePrise(
                  onphotoselectionne: (File? image) {
                    _imageSelected = image;
                  },
                ),
              ),

              SizedBox(height: 16),

              //textfield for user to enter the new place name
              TextField(
                cursorColor: Colors.black,
                controller: _placenameController,
                decoration: InputDecoration(
                  hint: Text(
                    'Place name',
                    style: TextStyle(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xff85c1d3), width: .5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xff6896a4),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              //textfield for user to enter the new place name
              TextField(
                cursorColor: Colors.black,
                controller: _descriptionController,
                decoration: InputDecoration(
                  hint: Text(
                    'Description',
                    style: TextStyle(color: Colors.grey),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xff85c1d3), width: .5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: Color(0xff6896a4),
                      width: 1.5,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              //button d'ajout d'endroit
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xff85c1d3),
                  shadowColor: Colors.teal,
                  elevation: 5,
                ),
                onPressed: _enregistreendroit,
                icon: Icon(CupertinoIcons.add, color: Colors.white),
                label: Text(
                  'Add a new place',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
