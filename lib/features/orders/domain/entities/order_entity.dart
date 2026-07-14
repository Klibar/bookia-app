import 'package:bookia/features/cart/domain/entities/cart_item_entity.dart';

class OrderEntity {
  final String orderNumber;
  final DateTime date;
  final String fullName;
  final String address;
  final String phone;
  final String governorate;
  final List<CartItemEntity> items;
  final double deliveryFee;
  final double discount;
  final String paymentMethod;

  const OrderEntity({
    required this.orderNumber,
    required this.date,
    required this.fullName,
    required this.address,
    required this.phone,
    required this.governorate,
    required this.items,
    this.deliveryFee = 10,
    this.discount = 0,
    this.paymentMethod = 'Cash/Wallet',
  });

  double get itemsPrice => items.fold(0, (sum, i) => sum + i.subtotal);
  double get total => itemsPrice + deliveryFee - discount;
}
