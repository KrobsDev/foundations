class Post {
  final String? pid, uid, image, content;

  Post({
    this.uid,
    this.pid,
    this.content,
    this.image,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uid: json['user_id'].toString(),
      pid: json['post_id'].toString(),
      content: json['content'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid.toString(),
        'pid': pid.toString(),
        'content': content,
        'image': image,
      };
}
