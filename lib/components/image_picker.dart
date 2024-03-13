// ignore_for_file: use_build_context_synchronously, unnecessary_string_interpolations, depend_on_referenced_packages

import 'package:firebase_storage/firebase_storage.dart' as storage;
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;

class MyImagePicker extends StatefulWidget {
  final Function(String imageUrl) onImageSelected;

  const MyImagePicker({
    super.key,
    required this.onImageSelected,
  });

  @override
  State<MyImagePicker> createState() => _MyImagePickerState();
}

class _MyImagePickerState extends State<MyImagePicker> {
  Uint8List? _image;
  File? selectedImage;

  final ImagePicker _picker = ImagePicker();
  late String imageUrl;

  @override
  void dispose() {
    _image = null;
    super.dispose();
  }

  Future _uploadFile(String path) async {
    final ref = storage.FirebaseStorage.instance
        .ref()
        .child('images')
        .child('${DateTime.now().toIso8601String() + p.basename(path)}');

    final result = await ref.putFile(File(path));
    final fileUrl = await result.ref.getDownloadURL();

    setState(() {
      imageUrl = fileUrl;
    });
    widget.onImageSelected(imageUrl);
  }

  //* Get image from gallery
  Future _pickImageFromGallery() async {
    final returnImage = await _picker.pickImage(source: ImageSource.gallery);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    await _uploadFile(returnImage.path);
  }

  //* Get image from camera
  Future _pickImageFromCamera() async {
    final returnImage = await _picker.pickImage(source: ImageSource.camera);
    if (returnImage == null) return;
    setState(() {
      selectedImage = File(returnImage.path);
      _image = File(returnImage.path).readAsBytesSync();
    });
    await _uploadFile(returnImage.path);
  }

  void showImagePickerOption(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.black,
      context: context,
      builder: (builder) {
        return SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 4.5,
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _pickImageFromCamera,
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.camera_alt_rounded,
                            color: Colors.orange,
                            size: 70,
                          ),
                          Text(
                            'מצלמה',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: _pickImageFromGallery,
                    child: const SizedBox(
                      child: Column(
                        children: [
                          Icon(
                            Icons.photo_library,
                            color: Colors.orange,
                            size: 70,
                          ),
                          Text(
                            'גלריה',
                            style: TextStyle(
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.yellow[600],
      borderRadius: BorderRadius.circular(20),
      onTap: () => showImagePickerOption(context),
      child: _image == null
          ? Ink(
              height: 200,
              width: 350,
              decoration: const BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
                border: Border.fromBorderSide(
                  BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
              ),
              child: const Icon(
                Icons.add_a_photo,
                size: 50,
              ),
            )
          : Ink(
              height: 200,
              width: 350,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                border: const Border.fromBorderSide(
                  BorderSide(
                    color: Colors.white,
                    width: 1,
                  ),
                ),
                image: DecorationImage(
                  image: MemoryImage(_image!),
                  fit: BoxFit.cover,
                ),
              ),
            ),
    );
  }
}
