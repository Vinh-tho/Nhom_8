import '../../../domain/entities/cart_item.dart';

/// CartState - MVVM Model: Immutable state cho giỏ hàng
class CartState {
  final List<CartItem> items;
  final Set<String> selectedProductIds;
  final bool isLoading;

  const CartState({
    this.items = const [],
    this.selectedProductIds = const {},
    this.isLoading = true,
  });

  CartState copyWith({
    List<CartItem>? items,
    Set<String>? selectedProductIds,
    bool? isLoading,
  }) {
    return CartState(
      items: items ?? this.items,
      selectedProductIds: selectedProductIds ?? this.selectedProductIds,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  int get totalQuantity {
    if (items.isEmpty) return 0;
    return items.fold(0, (sum, item) => sum + item.quantity);
  }

  double get totalPrice {
    if (items.isEmpty) return 0;
    return items.fold(0.0, (sum, item) => sum + item.totalPrice);
  }

  int get itemCount => items.length;

  bool get isEmpty => items.isEmpty;

  bool isProductSelected(String productId) =>
      selectedProductIds.contains(productId);

  bool isInCart(String productId) {
    return items.any((item) => item.product.id == productId);
  }

  int getQuantity(String productId) {
    var item = items.where((item) => item.product.id == productId).firstOrNull;
    return item?.quantity ?? 0;
  }
}
