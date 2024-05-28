

class Post {
  final String id;
  final String userId;
  final String content;
  final Map position;
  final String time;
  final String date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.position,
    required this.time,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'].toString(),
      userId: json['userId'],
      content: json['content'],
      position: json['position'],
      time: json['time'],
      date: json['date'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'content': content,
      'position': position,
      'time': time,
      'date': date,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  static List<Post> fromListJson(List<dynamic> json) {

    List<Post> posts = [];
    for (var post in json) {
      posts.add(Post.fromJson(post));
    }
    print(posts);
    return posts;
  }
}