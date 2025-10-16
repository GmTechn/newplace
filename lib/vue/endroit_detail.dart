import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/modele/endroit.dart';

class EndroitDetail extends StatelessWidget {
  final Endroit endroit;

  const EndroitDetail({super.key, required this.endroit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(endroit.nom)),
      body: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //image of the place
            Padding(padding: const EdgeInsets.all(8.0), child: Container()),

            //picture of the place
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Column(
                  children: [
                    //container to display image of the selected place
                    endroit.image != null
                        ? ClipRRect(
                            borderRadius: BorderRadiusGeometry.circular(9),
                            child: Image.file(
                              File(endroit.image!),
                              fit: BoxFit.cover,
                            ),
                          )
                        : Image.asset(
                            'assets/images/computer.jpg',
                            fit: BoxFit.cover,
                          ),
                    SizedBox(height: 30),
                    Text(endroit.nom, textAlign: TextAlign.center),
                    SizedBox(height: 10),
                    Text(endroit.description, textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
