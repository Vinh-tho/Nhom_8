import 'package:flutter_riverpod/flutter_riverpod.dart';

/// navigationIndexProvider - MVVM ViewModel: Quản lý trạng thái điều hướng tab
final navigationIndexProvider = StateProvider<int>((ref) => 0);
