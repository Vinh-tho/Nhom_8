import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/providers/repository_providers.dart';
import '../models/product_model.dart';
import '../services/product_detail_service.dart';

final productDetailServiceProvider = Provider<ProductDetailService>((ref) {
  return ProductDetailService(repository: ref.read(productRepositoryProvider));
});

final productDetailViewModelProvider = FutureProvider.autoDispose
    .family<Product?, String>((ref, productId) async {
      if (productId.isEmpty) return null;
      return ref.read(productDetailServiceProvider).getProductById(productId);
    });
