# ShopCart - Ứng dụng giỏ hàng demo

Ứng dụng mua sắm minh họa kiến trúc MVC và MVVM trong Flutter, kết hợp BLoC, Cubit và Riverpod để quản lý state.

## Tính năng

- Đăng nhập và đăng ký với validate email/mật khẩu.
- Danh sách sản phẩm dạng grid responsive.
- Xem chi tiết sản phẩm.
- Thêm, xóa, tăng giảm số lượng trong giỏ hàng.
- Lưu giỏ hàng cục bộ bằng SharedPreferences.
- Thanh toán mô phỏng.

## Kiến trúc hiện tại

Dự án đang chuẩn hóa theo 2 kiến trúc chính cho đề tài:

### 1. MVC cho Product List

Thành phần:

- View: `lib/features/product_list/views/product_list_view.dart`
- Controller: `lib/features/product_list/controllers/product_list_controller.dart`
- Model: `lib/features/product_list/models/product_list_state.dart`, `lib/domain/entities/product.dart`

Luồng:

1. `ProductListScreen` đọc state từ `productListControllerProvider`.
2. `ProductListController` gọi `ProductRepository.getAllProducts()`.
3. Controller cập nhật `ProductListState` (`isLoading`, `products`, `errorMessage`).
4. View render theo state (loading, error, data).

### 2. MVVM cho Product Detail

Thành phần:

- View: `lib/features/product_detail/views/product_detail_view.dart`
- ViewModel: `lib/features/product_detail/viewmodels/product_detail_viewmodel.dart`
- Service: `lib/features/product_detail/services/product_detail_service.dart`
- Model dùng cho UI: `Product` (export qua `lib/features/product_detail/models/product_model.dart`)

Luồng:

1. View gọi `ref.watch(productDetailViewModelProvider(productId))`.
2. ViewModel gọi Service.
3. Service gọi Repository.
4. Repository trả về `Product?`.
5. View render theo `AsyncValue<Product?>`.

## Kiến trúc bổ trợ

### Auth bằng BLoC và Cubit

- `FormCubit` quản lý state form email/password.
- `LoginBloc` xử lý `LoginRequested`, `RegisterRequested`.
- `AuthRepository` xử lý login/register giả lập.

Các file chính:

- `lib/presentation/auth/form/form_cubit.dart`
- `lib/presentation/auth/form/auth_form_state.dart`
- `lib/presentation/auth/login/login_bloc.dart`
- `lib/presentation/auth/login/login_event.dart`
- `lib/presentation/auth/login/login_state.dart`
- `lib/data/repositories/auth_repository.dart`

### Cart bằng Riverpod Notifier

- `CartNotifier` quản lý `CartState`.
- `CartState` chứa `List<CartItem>` với `CartItem.product` là `Product` domain entity.
- Lưu trữ giỏ hàng qua `CartRepository` abstraction ở Domain.
- Data layer dùng `SharedPrefsCartRepository` để map `Product <-> ProductModel` khi serialize/deserialize.

Các file chính:

- `lib/features/cart/viewmodels/cart_notifier.dart`
- `lib/features/cart/models/cart_state.dart`
- `lib/domain/repositories/cart_repository.dart`
- `lib/data/repositories/shared_prefs_cart_repository.dart`

### Data layer

- DataSource: `lib/data/datasources/fake_product_datasource.dart`
- Repository: `lib/data/repositories/product_repository.dart`

`ProductRepository` hiện trả về domain entity `Product`:

- `List<Product> getAllProducts()`
- `Product? getProductById(String id)`

## Quy tắc phụ thuộc (dependency direction)

- Presentation View không gọi DataSource trực tiếp.
- Product List View gọi Controller (MVC).
- Product Detail View gọi ViewModel (MVVM).
- Service và Controller gọi Repository.
- Domain entity không phụ thuộc ngược vào Presentation.

## Cấu trúc thư mục

```text
lib/
├── main.dart
├── app.dart
├── core/
│   ├── constants/
│   ├── mixins/
│   ├── providers/
│   │   └── repository_providers.dart
│   └── services/
├── data/
│   ├── datasources/
│   ├── models/
│   └── repositories/
├── domain/
│   └── entities/
├── features/
│   ├── cart/
│   │   ├── models/
│   │   └── viewmodels/
│   ├── product_list/
│   │   ├── controllers/
│   │   ├── models/
│   │   ├── views/
│   │   └── widgets/
│   └── product_detail/
│       ├── models/
│       ├── services/
│       ├── viewmodels/
│       └── views/
└── presentation/
    ├── auth/
    ├── providers/
    ├── screens/
    └── widgets/
```

## Cài đặt và chạy

Yêu cầu:

- Flutter SDK 3.10+
- Dart 3.10+

Cài dependencies:

```bash
flutter pub get
```

Chạy ứng dụng:

```bash
flutter run
```

Chạy theo nền tảng:

```bash
flutter run -d chrome
flutter run -d android
flutter run -d ios
flutter run -d windows
```

## Tài khoản demo

- Email: bất kỳ có ký tự `@` (ví dụ `test@demo.com`)
- Mật khẩu: tối thiểu 6 ký tự (ví dụ `123456`)

## License

Dự án dùng cho mục đích học tập và demo.
