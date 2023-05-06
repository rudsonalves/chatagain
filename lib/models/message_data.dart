import 'package:cloud_firestore/cloud_firestore.dart';

class MessageData {
  String uid;
  Timestamp date;
  String senderName;
  String senderPhotoUrl;
  String? message;
  String? imageUrl;

  MessageData({
    required this.uid,
    required this.date,
    required this.senderName,
    required this.senderPhotoUrl,
    this.message,
    this.imageUrl,
  });

  static MessageData fromMap(Map<String, dynamic> messageMap) {
    MessageData msgData = MessageData(
      uid: messageMap['uid'] as String,
      date: messageMap['date'] as Timestamp,
      senderName: messageMap['senderName'] as String,
      senderPhotoUrl: messageMap['senderPhotoUrl'] as String,
    );

    if (messageMap['message'] != null) {
      msgData.message = messageMap['message'] as String;
    } else {
      msgData.imageUrl = messageMap['imageUrl'] as String;
    }

    return msgData;
  }

  Map<String, dynamic> get toMap {
    Map<String, dynamic> map = <String, dynamic>{
      'uid': uid,
      'date': date,
      'senderName': senderName,
      'senderPhotoUrl': senderPhotoUrl,
    };
    if (imageUrl != null) map['imageUrl'] = imageUrl;
    if (message != null) map['message'] = message;

    return map;
  }

  @override
  String toString() {
    return 'uid: $uid\nsenderName: $senderName\n'
        'senderPhotoUrl: $senderPhotoUrl\nmessage: $message\n'
        'imageUrl: $imageUrl';
  }
}
