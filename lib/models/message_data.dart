class MessageData {
  final String uid;
  final String senderName;
  final String senderPhotoUrl;
  final String message;

  MessageData({
    required this.uid,
    required this.senderName,
    required this.senderPhotoUrl,
    required this.message,
  });

  static MessageData fromMap(Map<String, dynamic> messageMap) {
    return MessageData(
      uid: messageMap['uid'] as String,
      senderName: messageMap['senderName'] as String,
      senderPhotoUrl: messageMap['senderPhotoUrl'] as String,
      message: messageMap['message'] as String,
    );
  }

  @override
  String toString() {
    return 'uid: $uid\nsenderName: $senderName\n'
        'senderPhotoUrl: $senderPhotoUrl\nmessage: $message';
  }
}
