import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/providers/repository_providers.dart';
import '../../../data/repositories/product_repository.dart';
import '../models/product_list_state.dart';

class ProductListController extends ChangeNotifier {
  ProductListController(this._repository);

  final ProductRepository _repository;

  ProductListState _state = const ProductListState();
  ProductListState get state => _state;

  Future<void> loadProducts() async {
    _state = _state.copyWith(isLoading: true, errorMessage: null);
    notifyListeners();

    try {
      final products = _repository.getAllProducts();
      _state = _state.copyWith(
        isLoading: false,
        products: products,
        errorMessage: null,
      );
    } catch (_) {
      _state = _state.copyWith(
        isLoading: false,
        errorMessage: 'Khong the tai danh sach san pham.',
      );
    }

    notifyListeners();
  }
}

final productListControllerProvider =
    ChangeNotifierProvider<ProductListController>((ref) {
      final controller = ProductListController(
        ref.read(productRepositoryProvider),
      );
      controller.loadProducts();
      return controller;
    });
