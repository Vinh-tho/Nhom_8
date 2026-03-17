class Product {
  final String id;
  final String name;
  final String description;
  final String? fullDescription;
  final double price;
  final String imageUrl;
  final String category;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    this.fullDescription,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  Product copyWith({
    String? id,
    String? name,
    String? description,
    String? fullDescription,
    double? price,
    String? imageUrl,
    String? category,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      fullDescription: fullDescription ?? this.fullDescription,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
    );
  }
}
