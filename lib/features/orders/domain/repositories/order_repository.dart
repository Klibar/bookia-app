import 'package:bookia/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bookia/features/orders/domain/entities/order_entity.dart';

abstract class OrderRepository {
  Future<OrderEntity> placeOrder({
    required String fullName,
    required String address,
    required String phone,
    required String governorate,
    required List<CartItemEntity> items,
  });

  Future<List<OrderEntity>> getOrderHistory();
}
