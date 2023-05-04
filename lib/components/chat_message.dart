import 'package:flutter/material.dart';

import '../models/message_data.dart';

class ChatMessage extends StatelessWidget {
  final MessageData messageData;
  final String userId;

  const ChatMessage({
    super.key,
    required this.messageData,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    bool isFromUser = userId == messageData.uid;

    return Row(
      mainAxisAlignment:
          isFromUser ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 300,
          child: Card(
            color: isFromUser
                ? Theme.of(context).colorScheme.onPrimary
                : Theme.of(context).colorScheme.outlineVariant,
            elevation: 5,
            margin: const EdgeInsets.all(10),
            shape: isFromUser
                ? const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(15),
                    ),
                  )
                : const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(0),
                    ),
                  ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(messageData.senderPhotoUrl),
              ),
              title: Text(messageData.senderName),
              subtitle: messageData.message != null
                  ? Text(messageData.message ?? 'Null')
                  : Image.network(messageData.imageUrl!),
            ),
          ),
        ),
      ],
    );
  }
}
