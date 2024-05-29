class Conversation {
  final String id;
  final String firstUserId;
  final String secondUserId;

  Conversation({
    required this.id,
    required this.firstUserId,
    required this.secondUserId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      id: json['_id'],
      firstUserId: json['firstUserId'],
      secondUserId: json['secondUserId'],
    );
  }
}