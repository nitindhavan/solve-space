class Answer {
  final String answerId;
  final String content;
  int upvotes;
  int downvotes;
  final String userId;

  Answer({required this.answerId, required this.content, required this.upvotes, required this.downvotes, required this.userId});

  // Factory method to create an Answer from JSON
  factory Answer.fromJson(Map<String, dynamic> json) {
    return Answer(
      answerId: json['answerId'],
      content: json['content'],
      upvotes: json['upvotes'],
      downvotes: json['downvotes'],
      userId: json['userId'],
    );
  }
}