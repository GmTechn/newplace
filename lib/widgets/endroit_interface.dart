import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/modele/endroit.dart';
import 'package:flutter_application_3/providers/endroit_utilisateurs.dart';
import 'package:flutter_application_3/vue/ajout_endroit.dart';
import 'package:flutter_application_3/widgets/endroits_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EndroitsInterface extends ConsumerWidget {
  const EndroitsInterface({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //endroit utilisateur reading from provider
    final _endroitsutilisateur = ref.watch(endroitsprovider);

    return Scaffold(
      //---APPBAR----//
      appBar: AppBar(
        backgroundColor: Color(0xff76abbb),
        title: Text(
          'Favorite Places',
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
      ),

      //----BODY----//
      body: Padding(
        padding: EdgeInsets.all(10),
        child: EndroitsList(endroits: _endroitsutilisateur),
      ),

      //----BOTTOM---///
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff76abbb),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AjoutEndroit()),
          );
        },
        child: Icon(CupertinoIcons.plus, color: Colors.white),
      ),
    );
  }
}
