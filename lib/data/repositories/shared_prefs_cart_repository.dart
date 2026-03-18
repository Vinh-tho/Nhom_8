import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/product_model.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

class SharedPrefsCartRepository implements CartRepository {
  static const String _cartKey = 'cart_items';

  @override
  Future<List<CartItem>> loadCartItems() async {
    final prefs = await SharedPreferences.getInstance();
    final cartJson = prefs.getString(_cartKey);

    if (cartJson == null || cartJson.isEmpty) {
      return const [];
    }

    final decoded = jsonDecode(cartJson) as List<dynamic>;
    return decoded
        .map((item) {
          final map = item as Map<String, dynamic>;
          final quantityValue = map['quantity'];

          return CartItem(
            product: ProductModel.fromJson(
              map['product'] as Map<String, dynamic>,
            ).toEntity(),
            quantity: quantityValue is int
                ? quantityValue
                : (quantityValue as num).toInt(),
          );
        })
        .toList(growable: false);
  }

  @override
  Future<void> saveCartItems(List<CartItem> items) async {
    final prefs = await SharedPreferences.getInstance();
    final itemsJson = items
        .map(
          (item) => {
            'product': ProductModel.fromEntity(item.product).toJson(),
            'quantity': item.quantity,
          },
        )
        .toList(growable: false);

    await prefs.setString(_cartKey, jsonEncode(itemsJson));
  }
}
