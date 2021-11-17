import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CreatePage extends StatefulWidget {
  final User? user;

  CreatePage(this.user);

  //const CreatePage({Key? key}) : super(key: key);

  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final textEditingController = TextEditingController();

  PickedFile? _image;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
      floatingActionButton: FloatingActionButton(onPressed: () => _getImage(),
          child: const Icon(Icons.add_a_photo),),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      actions: [
        IconButton(onPressed: () {
          final firebaseStorageRef = FirebaseStorage.instance
              .ref()
              .child('post')
              .child('${DateTime.now().millisecondsSinceEpoch}.png');
          final task = firebaseStorageRef.putFile(
            File(_image!.path), SettableMetadata(contentType: 'image/png'));

          task.then((value) {
            var downloadUrl = value.ref.getDownloadURL();
            downloadUrl.then((uri) {
              var doc = FirebaseFirestore.instance.collection('post').doc();
              doc.set({
                'id': doc.id,
                'photoUrl': uri.toString(),
                'contents': textEditingController.text,
                'email': widget.user!.email,
                'displayName': widget.user!.displayName,
                'userPhotoUrl': widget.user!.photoURL
              }).then((v) {
                Navigator.pop(context);
              });
            });
          });
        }, icon: const Icon(Icons.send)),
      ],
    );
  }

  Widget _buildBody() {
    return  SingleChildScrollView(
      child: Column(children: [
        _image == null ? Text('No Image') : kIsWeb ? Image.network(_image!.path) : Image.file(File(_image!.path)),
        TextField(
          decoration: const InputDecoration(hintText: '내용을 입력하세요'),
          controller: textEditingController,
        )
      ]),
    );
  }

  Future _getImage() async {
    var image = await ImagePicker.platform.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }
}
