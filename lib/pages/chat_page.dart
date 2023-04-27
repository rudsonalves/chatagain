import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../components/text_composer.dart';
import '../firebase_options.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController? messageController;

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage({String? message, XFile? imageFile}) async {
    String? imageURL;
    Map<String, dynamic> msgData = {};

    if (message != null) {
      msgData['message'] = message;
    }

    if (imageFile != null) {
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().microsecondsSinceEpoch.toString())
          .putFile(File(imageFile.path));

      await uploadTask.whenComplete(
        () async {
          imageURL = await uploadTask.snapshot.ref.getDownloadURL();
        },
      );

      msgData['imageURL'] = imageURL;
    }

    if (msgData.isNotEmpty) {
      FirebaseFirestore firebase = FirebaseFirestore.instance;
      firebase.collection('messages').add(msgData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('messages').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done ||
                    snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  List<QueryDocumentSnapshot> docsList =
                      snapshot.data!.docs.reversed.toList();

                  return ListView.builder(
                    itemCount: docsList.length,
                    reverse: true,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(docsList[index].get('message')),
                      );
                    },
                  );
                }
              },
            ),
          ),
          TextComposer(sendMessage: _sendMessage),
        ],
      ),
    );
  }
}
