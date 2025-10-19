import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImagePrise extends StatefulWidget {
  //function for image

  final void Function(File? image) onphotoselectionne;
  const ImagePrise({super.key, required this.onphotoselectionne});

  @override
  State<ImagePrise> createState() => _ImagePriseState();
}

class _ImagePriseState extends State<ImagePrise> {
  //generate file to store photo
  File? _photoselected;

  //function to pick image from camera
  Future<void> _takepick() async {
    //picker instance generation
    final _imagePicker = ImagePicker();

    //picking image source
    final phototaken = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 500,
      imageQuality: 70,
    );

    if (phototaken == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Color(0xff6896a4),
          content: Text('Unable to pick an image.'),
        ),
      );
      return;
    }

    //transfert file photo & change image to file
    setState(() {
      _photoselected = File(phototaken.path);
    });

    //make widget available on all pages
    widget.onphotoselectionne(_photoselected!);
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _photoselected == null
          ? TextButton.icon(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.resolveWith<Color?>((
                  Set<WidgetState> states,
                ) {
                  if (states.contains(WidgetState.hovered)) {
                    // ignore: deprecated_member_use
                    return Color.fromARGB(255, 107, 156, 169).withOpacity(0.5);

                    //Glow on hover
                  } else if (states.contains(WidgetState.pressed)) {
                    return Color.fromARGB(255, 155, 213, 230); // Glow on press
                  }
                }),
                // Overlay color for ripple effect
                overlayColor: WidgetStateProperty.all(
                  // ignore: deprecated_member_use
                  Colors.white.withOpacity(0.3),
                ),
                // Elevation to enhance the glow effect
                elevation: MaterialStateProperty.all(5),
              ),

              icon: Icon(
                CupertinoIcons.camera_fill,
                size: 28,
                color: Color(0xff6896a4),
              ),
              onPressed: () => _takepick(),
              label: Text(
                'Take a picture.',
                style: TextStyle(color: Color(0xff6896a4)),
              ),
            )
          : GestureDetector(
              onTap: () => _takepick(),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  _photoselected!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
