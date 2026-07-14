import 'package:bookia/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bookia/features/orders/domain/entities/order_entity.dart';
import 'package:bookia/features/orders/domain/repositories/order_repository.dart';

/// In-memory dummy order history. TODO: replace with POST /orders and
/// GET /orders calls once the real API is ready (same Dio pattern used in
/// AuthRepositoryImpl) — callers only depend on [OrderRepository].
class OrderRepositoryImpl implements OrderRepository {
  final List<OrderEntity> _orders = [];
  int _counter = 238562312;

  @override
  Future<OrderEntity> placeOrder({
    required String fullName,
    required String address,
    required String phone,
    required String governorate,
    required List<CartItemEntity> items,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final order = OrderEntity(
      orderNumber: '#${_counter++}',
      date: DateTime.now(),
      fullName: fullName,
      address: address,
      phone: phone,
      governorate: governorate,
      items: items,
      discount: items.isNotEmpty ? 1.0 : 0,
    );
    _orders.insert(0, order);
    return order;
  }

  @override
  Future<List<OrderEntity>> getOrderHistory() async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _orders;
  }
}
