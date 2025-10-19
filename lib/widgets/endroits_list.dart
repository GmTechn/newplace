import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_3/modele/endroit.dart';
import 'package:flutter_application_3/vue/endroit_detail.dart';
import 'package:flutter_application_3/providers/endroit_utilisateurs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EndroitsList extends ConsumerStatefulWidget {
  const EndroitsList({super.key, required List<Endroit> endroits});

  @override
  ConsumerState<EndroitsList> createState() => _EndroitsListState();
}

class _EndroitsListState extends ConsumerState<EndroitsList> {
  @override
  Widget build(BuildContext context) {
    // get the list of favorite places from the provider
    final endroits = ref.watch(endroitsprovider);

    return Scaffold(
      body: endroits.isEmpty
          ? const Center(child: Text('You have no favorite place saved yet!'))
          : ListView.builder(
              itemCount: endroits.length,
              itemBuilder: (BuildContext context, int index) {
                final favoriteplace = endroits[index];

                return Dismissible(
                  key: Key(favoriteplace.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: const Color.fromARGB(255, 208, 18, 18),
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  onDismissed: (direction) {
                    // remove the place from provider state
                    ref.read(endroitsprovider.notifier).removeAt(index);
                  },
                  child: Card(
                    elevation: 10,
                    shadowColor: Color.fromARGB(255, 135, 197, 216),
                    child: ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff85c1d3),
                        backgroundImage: favoriteplace.image != null
                            ? FileImage(File(favoriteplace.image!))
                            : const AssetImage('assets/images/computer.jpg')
                                  as ImageProvider,
                      ),
                      title: Text(favoriteplace.nom),
                      subtitle: Text(favoriteplace.description),
                      contentPadding: const EdgeInsets.all(10),
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
                  ),
                );
              },
            ),
    );
  }
}
