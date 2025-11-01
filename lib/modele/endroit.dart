// 📦 modele/endroit.dart
class Endroit {
  final String id;
  final String nom;
  final String description;
  final String? image;

  Endroit({
    required this.id,
    required this.nom,
    required this.description,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {'id': id, 'nom': nom, 'description': description, 'image': image};
  }

  factory Endroit.fromMap(Map<String, dynamic> map) {
    return Endroit(
      id: map['id'] as String,
      nom: map['nom'] as String,
      description: map['description'] as String,
      image: map['image'] as String?,
    );
  }
}
