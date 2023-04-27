import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../components/text_composer.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController? messageController;
  GoogleSignIn googleSignIn = GoogleSignIn();
  User? _currentUser;

  Future<User?> _getUser() async {
    if (_currentUser != null) return _currentUser;

    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );

        final UserCredential authResult =
            await FirebaseAuth.instance.signInWithCredential(credential);

        return authResult.user;
      }
    } catch (error) {
      log('ERROR: ${error.toString()}');
      return null;
    }
  }

  void _showUnableLogin() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Unable to login. Try later.',
        ),
      ),
    );
  }

  void _sendMessage({String? message, XFile? imageFile}) async {
    final User? user = await _getUser();

    if (user == null) {
      _showUnableLogin();
      return;
    }

    Map<String, dynamic> data = {
      'uid': user.uid,
      'senderName': user.displayName,
      'senderPhotoUrl': user.photoURL,
    };

    if (message != null) {
      data['message'] = message;
    }

    if (imageFile != null) {
      String? imageURL;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().microsecondsSinceEpoch.toString())
          .putFile(File(imageFile.path));

      await uploadTask.whenComplete(
        () async {
          imageURL = await uploadTask.snapshot.ref.getDownloadURL();
        },
      );

      data['imageURL'] = imageURL;
    }

    if (data.isNotEmpty) {
      FirebaseFirestore firebase = FirebaseFirestore.instance;
      firebase.collection('messages').add(data);
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
