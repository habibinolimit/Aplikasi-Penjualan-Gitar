class Guitar {
  String noproduct;
  String name;
  String price;
  String description;
  String imageUrl;

  Guitar({
    required this.noproduct,
    required this.name,
    required this.price,
    required this.description,
    required this.imageUrl,
  });

  factory Guitar.fromJson(Map<String, dynamic> json) {
    return Guitar(
      noproduct: json['noproduct'] as String,
      name: json['name'] as String,
      price: json['price'].toString(),
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'noproduct': noproduct,
      'name': name,
      'price': price,
      'description': description,
      'imageUrl': imageUrl,
    };
  }
}
