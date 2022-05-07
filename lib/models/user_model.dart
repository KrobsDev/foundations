class User {
  final String? uid, phone;
  final String? fname, lname, image, email, password;

  User({
    this.uid,
    this.fname,
    this.lname,
    this.phone,
    this.image,
    this.email,
    this.password,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['user_id'].toString(),
      fname: json['user_fname'],
      lname: json['user_lname'],
      email: json['user_email'],
      phone: json['user_phone'],
      password: json['user_pass'],
      image: json['user_image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'uid': uid.toString(),
        'fname': fname,
        'lname': lname,
        'email': email,
        'phone': phone,
        'password': password,
        'image': image,
      };
}
