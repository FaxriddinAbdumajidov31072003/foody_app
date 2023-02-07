class MessageModel {
  final String title;
  final DateTime time;
  final String ownerId;
  final String messId;

  MessageModel({
    required this.title,
    required this.time,
    required this.ownerId,
    required this.messId,
  });

  factory MessageModel.fromJson({required Map data, required String messId}) {
    return MessageModel(
      title: data["title"],
      time: DateTime.parse(data["time"]),
      ownerId: data["ownerId"],
      messId: messId,
    );
  }

  toJson() {
    return {"title": title, "time": time.toString(), "ownerId": ownerId};
  }
}