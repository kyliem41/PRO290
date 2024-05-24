import 'package:mongo_dart/mongo_dart.dart';

class Post {
  final ObjectId id;
  final String userId;
  final String content;
  final String location;
  final String time;
  final String date;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.location,
    required this.time,
    required this.date,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'],
      userId: json['userId'],
      content: json['content'],
      location: json['location'],
      time: json['time'],
      date: json['date'],
      createdAt: json['createdAt'].toDate(),
      updatedAt: json['updatedAt'].toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'content': content,
      'location': location,
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