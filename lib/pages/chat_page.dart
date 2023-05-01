import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import '../components/chat_message.dart';
import '../components/text_composer.dart';
import '../models/message_data.dart';

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

  @override
  void initState() {
    super.initState();
  }

  void _sendMessage({String? message, XFile? imageFile}) async {
    final User? user = await _getUser();

    if (user == null) {
      _showUnableLogin();
      return;
    }

    MessageData messageData = MessageData(
      uid: user.uid,
      senderName: user.displayName!,
      senderPhotoUrl: user.photoURL!,
      date: DateTime.now().toIso8601String(),
    );

    if (message != null) {
      messageData.message = message;
    }

    if (imageFile != null) {
      String? imageUrl;
      UploadTask uploadTask = FirebaseStorage.instance
          .ref()
          .child(DateTime.now().microsecondsSinceEpoch.toString())
          .putFile(File(imageFile.path));

      await uploadTask.whenComplete(
        () async {
          imageUrl = await uploadTask.snapshot.ref.getDownloadURL();
        },
      );

      messageData.imageUrl = imageUrl;
    }

    if ((messageData.message != null && messageData.message!.isNotEmpty) ||
        messageData.imageUrl != null) {
      // log('write message: $messageData');
      FirebaseFirestore firebase = FirebaseFirestore.instance;
      firebase.collection('messages').add(messageData.toMap);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('messages')
                  .orderBy('date')
                  .snapshots(),
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
                      MessageData msgData = MessageData.fromMap(
                          docsList[index].data() as Map<String, dynamic>);
                      return ChatMessage(msgData);
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
