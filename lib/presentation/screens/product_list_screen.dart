import 'package:flutter/material.dart';

import '../../features/product_list/views/product_list_view.dart';

/// Wrapper giữ tương thích import cũ
class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductListView();
  }
}
