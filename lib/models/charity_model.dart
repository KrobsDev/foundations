class CharityModel {
  final String? cid, name, image, description, location, amount, target;

  CharityModel({
    this.amount,
    this.target,
    this.name,
    this.image,
    this.cid,
    this.location,
    this.description,
  });

  factory CharityModel.fromJson(Map<String, dynamic> json) {
    return CharityModel(
      cid: json['charity_id'].toString(),
      name: json['charity_name'].toString(),
      description: json['description'],
      image: json['image'],
      location: json['location'],
      amount: json['amount_raised'].toString(),
      target: json['target'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'cid': cid.toString(),
        'name': name.toString(),
        'location': location,
        'description': description,
        'image': image,
        'amount': amount.toString(),
        'target': target.toString(),
      };
}
