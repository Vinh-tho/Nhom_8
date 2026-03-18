import '../../../domain/entities/product.dart';

class ProductListState {
  final bool isLoading;
  final List<Product> products;
  final String? errorMessage;

  const ProductListState({
    this.isLoading = true,
    this.products = const [],
    this.errorMessage,
  });

  ProductListState copyWith({
    bool? isLoading,
    List<Product>? products,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ProductListState(
      isLoading: isLoading ?? this.isLoading,
      products: products ?? this.products,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
