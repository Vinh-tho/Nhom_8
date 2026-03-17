import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/mixins/validation_mixin.dart';
import '../../data/models/product_model.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/entities/product.dart';
import 'cart_state.dart';

export 'cart_state.dart';

// ============================================
// NOTIFIER
// ============================================

class CartNotifier extends Notifier<CartState> with ValidationMixin {
  static const String _cartKey = 'cart_items';

  @override
  CartState build() {
    // Khởi tạo state ban đầu
    // Load data async sau khi build xong
    _loadCart();
    return const CartState(isLoading: true);
  }

  // Load từ Storage
  Future<void> _loadCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final cartJson = prefs.getString(_cartKey);

      List<CartItem> items = [];
      if (cartJson != null && cartJson.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(cartJson);
        items = decoded.map((item) {
          final map = item as Map<String, dynamic>;
          return CartItem(
            product: ProductModel.fromJson(
              map['product'] as Map<String, dynamic>,
            ).toEntity(),
            quantity: map['quantity'] as int,
          );
        }).toList();
      }

      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      debugPrint('Error loading cart: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  // Lưu vào Storage
  Future<void> _saveCart() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final itemsJson = state.items
          .map(
            (item) => {
              'product': ProductModel.fromEntity(item.product).toJson(),
              'quantity': item.quantity,
            },
          )
          .toList();
      await prefs.setString(_cartKey, jsonEncode(itemsJson));
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  // Thêm sản phẩm
  void addToCart(Product product) {
    // Clone list để đảm bảo immutability tuyệt đối
    final currentItems = List<CartItem>.from(state.items);
    final index = currentItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      // Tăng số lượng
      final item = currentItems[index];
      if (isValidQuantity(item.quantity + 1)) {
        currentItems[index] = item.copyWith(quantity: item.quantity + 1);
      }
    } else {
      // Thêm mới
      currentItems.add(CartItem(product: product));
    }

    state = state.copyWith(items: currentItems);
    _saveCart();
  }

  // Xóa sản phẩm
  void removeFromCart(String productId) {
    final currentItems = List<CartItem>.from(state.items);
    currentItems.removeWhere((item) => item.product.id == productId);

    final currentSelected = Set<String>.from(state.selectedProductIds);
    currentSelected.remove(productId);

    state = state.copyWith(
      items: currentItems,
      selectedProductIds: currentSelected,
    );
    _saveCart();
  }

  // Tăng/Giảm số lượng
  void incrementQuantity(String productId) {
    final currentItems = List<CartItem>.from(state.items);
    final index = currentItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      final item = currentItems[index];
      if (isValidQuantity(item.quantity + 1)) {
        currentItems[index] = item.copyWith(quantity: item.quantity + 1);
        state = state.copyWith(items: currentItems);
        _saveCart();
      }
    }
  }

  void decrementQuantity(String productId) {
    final currentItems = List<CartItem>.from(state.items);
    final index = currentItems.indexWhere(
      (item) => item.product.id == productId,
    );

    if (index != -1) {
      final item = currentItems[index];
      if (item.quantity > 1) {
        currentItems[index] = item.copyWith(quantity: item.quantity - 1);
        state = state.copyWith(items: currentItems);
        _saveCart();
      } else {
        removeFromCart(productId);
      }
    }
  }

  // Toggle select
  void toggleSelectProduct(String productId) {
    final currentSelected = Set<String>.from(state.selectedProductIds);
    if (currentSelected.contains(productId)) {
      currentSelected.remove(productId);
    } else {
      currentSelected.add(productId);
    }
    state = state.copyWith(selectedProductIds: currentSelected);
  }

  void clearCart() {
    state = state.copyWith(items: [], selectedProductIds: {});
    _saveCart();
  }
}

// ============================================
// PROVIDER
// ============================================

final cartProvider = NotifierProvider<CartNotifier, CartState>(() {
  return CartNotifier();
});
