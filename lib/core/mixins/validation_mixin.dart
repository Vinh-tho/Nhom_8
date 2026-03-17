import '../constants/app_constants.dart';

mixin ValidationMixin {
  // Kiểm tra số lượng có hợp lệ không
  bool isValidQuantity(int quantity) {
    return quantity >= AppConstants.minQuantityPerItem &&
        quantity <= AppConstants.maxQuantityPerItem;
  }
}
