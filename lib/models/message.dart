class Message {
  String messageId;
  String chatId;
  Role role;
  StringBuffer message; // Stream message from GEMINI MODEL

  List<String> imageUrls;
  DateTime timeSent;

  // Constructor
  Message({
    required this.messageId,
    required this.chatId,
    required this.role,
    required this.message,
    required this.imageUrls,
    required this.timeSent,
  });

  // Tomap
  Map<String, dynamic> toMap() {
    return {
      "messageId": messageId,
      "chatId": chatId,
      "role": role,
      "message": message.toString(),
      "imageUrls": imageUrls,
      "timeSent": timeSent,
    };
  }

  // FromMap
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      messageId: map['messageId'],
      chatId: map['chatId'],
      role: Role.values[map['role']],
      message: StringBuffer(map['message']),
      imageUrls: List<String>.from(map['imageUrls']),
      timeSent: DateTime.parse('timeSent'),
    );
  }

  Message copyWith({
    String? messageId,
    String? chatId,
    Role? role,
    StringBuffer? message,
    List<String>? imageUrls,
    DateTime? timeSent,
  }) {
    return Message(
      messageId: messageId ?? this.messageId,
      chatId: chatId ?? this.chatId,
      role: role ?? this.role,
      message: message ?? this.message,
      imageUrls: imageUrls ?? this.imageUrls,
      timeSent: timeSent ?? this.timeSent,
    );
  }
}

enum Role { user, assistant }
