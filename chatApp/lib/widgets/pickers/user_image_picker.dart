import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final Function(File pickedImage) _imagePickFn;

  UserImagePicker(this._imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage.path);
    widget._imagePickFn(pickedImageFile);
    setState(() => _pickedImage = pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? FileImage(_pickedImage) : null,
          backgroundColor: Colors.grey,
        ),
        FlatButton.icon(
          icon: Icon(Icons.image),
          label: Text('Add image'),
          textColor: Theme.of(context).primaryColor,
          onPressed: _pickImage,
        ),
      ],
    );
  }
}
