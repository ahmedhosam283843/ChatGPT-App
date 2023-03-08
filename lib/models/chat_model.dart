class ChatModel {
  final int chatIndex;
  final String msg;

  ChatModel({required this.msg, required this.chatIndex});

  factory ChatModel.fromJson(Map<String, dynamic> json) => ChatModel(
        chatIndex: json["chatIndex"],
        msg: json["msg"],
      );
}
