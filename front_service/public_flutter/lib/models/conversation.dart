class Conversation {
  final String conversationId;
  final String firstUserId;
  final String secondUserId;

  Conversation({
    required this.conversationId,
    required this.firstUserId,
    required this.secondUserId,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      conversationId: json['conversationId'],
      firstUserId: json['firstUserId'],
      secondUserId: json['secondUserId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'conversationId': conversationId,
      'firstUserId': firstUserId,
      'secondUserId': secondUserId,
    };
  }
}