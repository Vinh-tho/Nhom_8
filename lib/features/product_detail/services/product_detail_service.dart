import '../../../domain/repositories/product_repository.dart';
import '../../../domain/entities/product.dart';

/// ProductDetailService - Service lấy chi tiết sản phẩm (dùng Repository)
class ProductDetailService {
  ProductDetailService({required ProductRepositoryContract repository})
    : _repository = repository;

  final ProductRepositoryContract _repository;

  /// Lấy chi tiết sản phẩm theo ID
  /// Trả về null nếu không tìm thấy
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Giả lập network
    return _repository.getProductById(id);
  }
}
