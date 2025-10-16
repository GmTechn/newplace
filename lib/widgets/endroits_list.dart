import 'package:flutter/material.dart';
import 'package:flutter_application_3/modele/endroit.dart';
import 'package:flutter_application_3/vue/endroit_detail.dart';

class EndroitsList extends StatelessWidget {
  final List<Endroit> endroits;

  const EndroitsList({super.key, required this.endroits});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: endroits.isEmpty
          ? Center(child: Text('You have no favorite place saved yet!'))
          : ListView.builder(
              itemCount: endroits.length,
              itemBuilder: (BuildContext context, int index) {
                final favoriteplace = endroits[index];

                return Card(
                  elevation: 5,
                  shadowColor: Color(0xff85c1d3),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundColor: Color(0xff85c1d3),
                      backgroundImage: AssetImage('assets/images/computer.jpg'),
                    ),
                    title: Text(favoriteplace.nom),
                    subtitle: Text(favoriteplace.description),
                    contentPadding: EdgeInsets.all(10),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              EndroitDetail(endroit: favoriteplace),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
