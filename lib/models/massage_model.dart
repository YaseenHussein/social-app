class MassageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  MassageModel({
    required this.senderId,
    required this.receiverId,
    required this.dateTime,
    required this.text,
  });

  MassageModel.fromJson(Map<String, dynamic>? json) {
    senderId = json!['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
