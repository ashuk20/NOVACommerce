class Product {
  final int id;
  final String name;
  final String? description;
  final double price;
  final String? imageUrl;
  final int stockQuantity;
  final int categoryId;
  final String categoryName;

  const Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    this.imageUrl,
    required this.stockQuantity,
    required this.categoryId,
    required this.categoryName,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'],
      stockQuantity: json['stockQuantity'],
      categoryId: json['categoryId'],
      categoryName: json['categoryName'],
    );
  }
}
