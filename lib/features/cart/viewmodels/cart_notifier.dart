import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/mixins/validation_mixin.dart';
import '../../../core/providers/repository_providers.dart';
import '../../../domain/entities/cart_item.dart';
import '../../../domain/entities/product.dart';
import '../models/cart_state.dart';

export '../models/cart_state.dart';

class CartNotifier extends Notifier<CartState> with ValidationMixin {
  @override
  CartState build() {
    _loadCart();
    return const CartState(isLoading: true);
  }

  Future<void> _loadCart() async {
    try {
      final items = await ref.read(cartRepositoryProvider).loadCartItems();
      state = state.copyWith(items: items, isLoading: false);
    } catch (e) {
      debugPrint('Error loading cart: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> _saveCart() async {
    try {
      await ref.read(cartRepositoryProvider).saveCartItems(state.items);
    } catch (e) {
      debugPrint('Error saving cart: $e');
    }
  }

  void addToCart(Product product) {
    final currentItems = List.of(state.items);
    final index = currentItems.indexWhere(
      (item) => item.product.id == product.id,
    );

    if (index != -1) {
      final item = currentItems[index];
      if (isValidQuantity(item.quantity + 1)) {
        currentItems[index] = item.copyWith(quantity: item.quantity + 1);
      }
    } else {
      currentItems.add(CartItem(product: product));
    }

    state = state.copyWith(items: currentItems);
    _saveCart();
  }

  void removeFromCart(String productId) {
    final currentItems = List.of(state.items)
      ..removeWhere((item) => item.product.id == productId);

    final currentSelected = Set<String>.of(state.selectedProductIds)
      ..remove(productId);

    state = state.copyWith(
      items: currentItems,
      selectedProductIds: currentSelected,
    );
    _saveCart();
  }

  void incrementQuantity(String productId) {
    final currentItems = List.of(state.items);
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
    final currentItems = List.of(state.items);
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

  void toggleSelectProduct(String productId) {
    final currentSelected = Set<String>.of(state.selectedProductIds);
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

final cartProvider = NotifierProvider<CartNotifier, CartState>(
  CartNotifier.new,
);
