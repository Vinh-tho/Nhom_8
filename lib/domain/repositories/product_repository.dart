import '../entities/product.dart';

abstract class ProductRepositoryContract {
  List<Product> getAllProducts();

  Product? getProductById(String id);
}
