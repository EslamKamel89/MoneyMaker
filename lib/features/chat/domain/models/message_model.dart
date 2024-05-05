class MessageChat {
  final String senderId;
  final String senderName;
  final String text;
  final DateTime createdAt;
  MessageChat({
    required this.senderId,
    required this.senderName,
    required this.text,
    required this.createdAt,
  });
  static List<MessageChat> messagesChatStatic = [
    MessageChat(
        senderId: '4',
        senderName: 'Eslam Ahmed',
        text: "eight : I think it will go sideway",
        createdAt: DateTime(2024, 04, 04, 10, 40, 00)),
    MessageChat(
        senderId: '1',
        senderName: 'Osama Fathi',
        text: 'five : what the EUR/USD did today is amazing!',
        createdAt: DateTime(2024, 04, 04, 10, 30, 00)),
    MessageChat(
      senderId: '1',
      senderName: 'Osama Fathi',
      text: ' one : hi',
      createdAt: DateTime(2024, 04, 04, 10, 10, 00),
    ),
    MessageChat(
      senderId: '4',
      senderName: 'Eslam Ahmed',
      text: 'two : hi',
      createdAt: DateTime(2024, 04, 04, 10, 15, 00),
    ),
    MessageChat(
      senderId: '1',
      senderName: 'Osama Fathi',
      text: 'three : how are you?',
      createdAt: DateTime(2024, 04, 04, 10, 20, 00),
    ),
    MessageChat(
      senderId: '4',
      senderName: 'Eslam Ahmed',
      text: 'four : fine, thanks',
      createdAt: DateTime(2024, 04, 04, 10, 25, 00),
    ),
    MessageChat(
        senderId: '1',
        senderName: 'Osama Fathi',
        text: 'seven : What do you excpect the market will do in the next days?',
        createdAt: DateTime(2024, 04, 04, 10, 35, 00)),
    MessageChat(
      senderId: '1',
      senderName: 'Osama Fathi',
      text: "nine : Ok",
      createdAt: DateTime(2024, 04, 04, 10, 45, 00),
    ),
    MessageChat(
      senderId: '4',
      senderName: 'Eslam Ahmed',
      text: 'six : Agree with you 100%',
      createdAt: DateTime(2024, 04, 04, 10, 31, 00),
    ),
  ];
}
