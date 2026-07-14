import 'package:bookia/features/orders/domain/entities/order_entity.dart';

abstract class OrderState {}

class OrderInitialState extends OrderState {}

class OrderPlacingState extends OrderState {}

class OrderPlacedState extends OrderState {
  final OrderEntity order;
  OrderPlacedState(this.order);
}

class OrderErrorState extends OrderState {
  final String message;
  OrderErrorState(this.message);
}

class OrderHistoryLoadingState extends OrderState {}

class OrderHistoryLoadedState extends OrderState {
  final List<OrderEntity> orders;
  OrderHistoryLoadedState(this.orders);
}
