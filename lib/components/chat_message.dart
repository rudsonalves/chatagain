import 'package:flutter/material.dart';

import '../models/message_data.dart';

class ChatMessage extends StatelessWidget {
  const ChatMessage(
    this.messageData, {
    super.key,
  });

  final MessageData messageData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          width: 280,
          child: Card(
            elevation: 1,
            margin: const EdgeInsets.all(10),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(messageData.senderPhotoUrl),
              ),
              title: Text(messageData.senderName),
              subtitle: Text(messageData.message),
            ),
          ),
        ),
      ],
    );
  }
}
