class model {
  String? image;
  String? title;
  String? price;
  int? reviews;

  model({this.image, this.title, this.price, this.reviews});

  model.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    title = json['title'];
    price = json['price'];
    reviews = json['reviews'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['title'] = this.title;
    data['price'] = this.price;
    data['reviews'] = this.reviews;
    return data;
  }
}