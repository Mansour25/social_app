class MessageModel {
  late String sendId;

  late String receverId;

  late String dateTime;

  late String text;

  MessageModel({
    required this.sendId,
    required this.receverId,
    required this.dateTime,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    sendId = json['sendId'];
    receverId = json['receverId'];
    dateTime = json['dateTime'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'sendId': sendId,
      'receverId': receverId,
      'dateTime': dateTime,
      'text': text,
    };
  }
}
