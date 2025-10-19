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

  //textformfield key
  final _formKey = GlobalKey<FormState>();

  //disposing of the controller
  @override
  void dispose() {
    _placenameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  //enregistrer un endroit saved
  void _enregistreendroit() async {
    //controllers to store place and description
    final place = _placenameController.text;
    final description = _descriptionController.text;

    //please
    if (place.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a place'),
          backgroundColor: Color.fromARGB(255, 78, 112, 122),
        ),
      );
      return;
    }

    //add place to provider
    ref
        .read(endroitsprovider.notifier)
        .ajoutendroit(place, description, _imageSelected);

    //pop of context, go back to the display list
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff76abbb),
        title: const Text(
          'Add new place',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Form(
            // ✅ The Form widget wraps all your fields
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1.5,
                      color: const Color(0xff6896a4),
                    ),
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

                const SizedBox(height: 16),

                // ✅ TextFormField 1
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _placenameController,
                  decoration: InputDecoration(
                    hintText: 'Place name',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff85c1d3),
                        width: .5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff6896a4),
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a place name';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),

                // ✅ TextFormField 2
                TextFormField(
                  cursorColor: Colors.black,
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: const TextStyle(color: Colors.grey),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff85c1d3),
                        width: .5,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                        color: Color(0xff6896a4),
                        width: 1.5,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 30),

                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff85c1d3),
                    shadowColor: Colors.teal,
                    elevation: 5,
                  ),
                  onPressed: _enregistreendroit,
                  icon: const Icon(CupertinoIcons.add, color: Colors.white),
                  label: const Text(
                    'Add a new place',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
