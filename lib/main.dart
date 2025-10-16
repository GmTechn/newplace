import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/vue/ajout_endroit.dart';
import 'package:flutter_application_3/widgets/endroit_interface.dart';
import 'package:flutter_application_3/widgets/endroits_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/endroit_utilisateurs.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Favorites',
      home: const EndroitsInterface(),
    );
  }
}
