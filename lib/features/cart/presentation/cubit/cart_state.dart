import 'package:bookia/features/cart/domain/entities/cart_item_entity.dart';

class CartState {
  final List<CartItemEntity> items;

  const CartState(this.items);

  double get total => items.fold(0, (sum, item) => sum + item.subtotal);
  int get itemCount => items.fold(0, (sum, item) => sum + item.quantity);
}
