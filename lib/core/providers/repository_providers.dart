import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/shared_prefs_cart_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/repositories/cart_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return SharedPrefsCartRepository();
});
