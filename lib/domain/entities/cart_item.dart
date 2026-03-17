import 'product.dart';

/// CartItem - Entity: một dòng trong giỏ (product + quantity)
class CartItem {
  final Product product;
  final int quantity;

  const CartItem({required this.product, this.quantity = 1});

  // Tính tổng tiền của item này
  double get totalPrice => product.price * quantity;

  // Tạo bản sao mới với các giá trị thay đổi (Immutability)
  CartItem copyWith({Product? product, int? quantity}) {
    return CartItem(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
