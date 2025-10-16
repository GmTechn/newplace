import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/modele/endroit.dart';
import 'package:flutter_application_3/widgets/imageprise.dart';

class EndroitDetail extends StatelessWidget {
  final Endroit endroit;

  const EndroitDetail({super.key, required this.endroit});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(endroit.nom)),
      body: Column(
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
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 1.5, color: Color(0xff6896a4)),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 200,
                    width: double.infinity,
                    child: Image.asset('assets/images/computer.jpg'),
                  ),
                  SizedBox(height: 30),
                  Text(endroit.nom),
                  SizedBox(height: 10),
                  Text(endroit.description),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
