import '../entities/cart_item.dart';

/// CartRepository - Abstraction cho lưu/đọc giỏ hàng
abstract class CartRepository {
  Future<List<CartItem>> loadCartItems();

  Future<void> saveCartItems(List<CartItem> items);
}
