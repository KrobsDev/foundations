class Post {
  final String? uid, image, content, date, fname, lname, email, userImage;

  Post({
    this.fname,
    this.lname,
    this.email,
    this.userImage,
    this.uid,
    this.content,
    this.image,
    this.date,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      uid: json['user_id'].toString(),
      content: json['content'] as String,
      image: json['image'],
      date: json['dateTime'] as String,
      fname: json['fname'] as String,
      lname: json['lname'] as String,
      email: json['email'] as String,
      userImage: json['user_image'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid as String,
        'content': content as String,
        'image': image,
        'dateTime': date as String,
        'fname': fname as String,
        'lname': lname as String,
        'email': email as String,
        'userImage': userImage as String,
      };
}
