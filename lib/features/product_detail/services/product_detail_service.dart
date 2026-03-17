import '../../../data/repositories/product_repository.dart';
import '../models/product_model.dart';

/// ProductDetailService - Service lấy chi tiết sản phẩm (dùng Repository)
class ProductDetailService {
  ProductDetailService({required ProductRepository repository})
    : _repository = repository;

  final ProductRepository _repository;

  /// Lấy chi tiết sản phẩm theo ID
  /// Trả về null nếu không tìm thấy
  Future<Product?> getProductById(String id) async {
    await Future.delayed(const Duration(milliseconds: 300)); // Giả lập network
    return _repository.getProductById(id);
  }
}
