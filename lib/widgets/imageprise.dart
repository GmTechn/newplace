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

  //function to pick image (camera or gallery)
  Future<void> _chooseImageSource() async {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                // 📸 Camera option
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.camera_fill,
                    color: Color(0xff6896a4),
                  ),
                  title: const Text("Take a photo"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),

                // 🖼️ Gallery option
                ListTile(
                  leading: const Icon(
                    CupertinoIcons.photo_fill_on_rectangle_fill,
                    color: Color(0xff6896a4),
                  ),
                  title: const Text("Choose from gallery"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  //function to actually pick image
  Future<void> _pickImage(ImageSource source) async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(
      source: source,
      maxWidth: 500,
      imageQuality: 70,
    );

    if (pickedFile == null) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Color(0xff6896a4),
          content: Text('No image selected.'),
        ),
      );
      return;
    }

    setState(() {
      _photoselected = File(pickedFile.path);
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
                    return const Color.fromARGB(
                      255,
                      107,
                      156,
                      169,
                      // ignore: deprecated_member_use
                    ).withOpacity(0.5);
                  } else if (states.contains(WidgetState.pressed)) {
                    return const Color.fromARGB(255, 155, 213, 230);
                  }
                  return null;
                }),
                overlayColor: WidgetStateProperty.all(
                  // ignore: deprecated_member_use
                  Colors.white.withOpacity(0.3),
                ),
                elevation: WidgetStateProperty.all(5),
              ),
              icon: const Icon(
                CupertinoIcons.camera_fill,
                size: 28,
                color: Color(0xff6896a4),
              ),
              onPressed: _chooseImageSource, // ✅ new function
              label: const Text(
                'Take or select a picture',
                style: TextStyle(color: Color(0xff6896a4)),
              ),
            )
          : GestureDetector(
              onTap: _chooseImageSource, // ✅ also trigger source chooser
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
