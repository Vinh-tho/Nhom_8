import '../datasources/fake_product_datasource.dart';
import '../../domain/entities/product.dart';

/// ProductRepository - Trung gian giữa Data Source và UI/Service
class ProductRepository {
  // Lấy tất cả sản phẩm
  List<Product> getAllProducts() {
    return FakeProductDataSource.getProducts()
        .map((model) => model.toEntity())
        .toList(growable: false);
  }

  // Lấy chi tiết sản phẩm theo ID
  Product? getProductById(String id) {
    final products = FakeProductDataSource.getProducts();
    try {
      return products.firstWhere((p) => p.id == id).toEntity();
    } catch (_) {
      return null;
    }
  }
}
