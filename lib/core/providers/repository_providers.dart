import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/shared_prefs_cart_repository.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/product_repository.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/cart_repository.dart';
import '../../domain/repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepositoryContract>((ref) {
  return ProductRepository();
});

final authRepositoryProvider = Provider<AuthRepositoryContract>((ref) {
  return AuthRepository();
});

final cartRepositoryProvider = Provider<CartRepository>((ref) {
  return SharedPrefsCartRepository();
});
