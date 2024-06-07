class TransactionData {
  final String name;
  final String shippingAddress;
  final String contactNumber;
  final String jenisKelamin;
  final String noproduct;
  final String guitarName;
  final String guitarPrice;

  TransactionData({
    required this.name,
    required this.shippingAddress,
    required this.contactNumber,
    required this.jenisKelamin,
    required this.noproduct,
    required this.guitarName,
    required this.guitarPrice,
  });

   Map<String, dynamic> toJson() {
    return {
      'name': name,
      'shippingAddress': shippingAddress,
      'contactNumber': contactNumber,
      'jenisKelamin': jenisKelamin,
      'noproduct': noproduct,
      'guitarName': guitarName,
      'guitarPrice': guitarPrice,
    };
  }

  factory TransactionData.fromJson(Map<String, dynamic> json) {
    return TransactionData(
      name: json['name'],
      shippingAddress: json['shipping_address'],
      contactNumber: json['contact_number'],
      jenisKelamin: json['jenis_kelamin'],
      noproduct: json['noproduct'],
      guitarName: json['guitar_name'],
      guitarPrice: json['guitar_price'],
    );
  }
}

