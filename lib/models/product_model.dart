class ProductModel {
  final int id;
  final String imageUrl;
  final String title;
  final String brand;
  final double oldPrice;
  final double newPrice;
  final double discount;
  final int quantity;
  final double cartQuantityPrice;

  ProductModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.brand,
    required this.oldPrice,
    required this.newPrice,
    required this.discount,
    this.quantity = 1,
    this.cartQuantityPrice = 0.0,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double oldPrice = double.parse(json['price'].toString());
    double discountPercent =
        double.parse(json['discountPercentage'].toString());
    return ProductModel(
        id: json['id'],
        imageUrl: json['thumbnail'],
        title: json['title'],
        brand: json['brand'] ?? 'xyz',
        oldPrice: oldPrice,
        newPrice: ProductModel._calculateNewPrice(oldPrice, discountPercent),
        discount: discountPercent);
  }
  // Static method to calculate new price
  static double _calculateNewPrice(double oldPrice, double discountPercent) {
    return oldPrice * (1 - discountPercent / 100);
  }

  ProductModel copyWith({int quantity = 1}) {
    return ProductModel(
        id: id,
        imageUrl: imageUrl,
        title: title,
        brand: brand,
        oldPrice: oldPrice,
        newPrice: newPrice,
        quantity: quantity,
        discount: discount);
  }
}
