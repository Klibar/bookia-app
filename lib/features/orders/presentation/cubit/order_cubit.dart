import 'package:bookia/features/cart/domain/entities/cart_item_entity.dart';
import 'package:bookia/features/orders/domain/repositories/order_repository.dart';
import 'package:bookia/features/orders/presentation/cubit/order_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderState> {
  final OrderRepository repository;

  OrderCubit(this.repository) : super(OrderInitialState());

  Future<void> placeOrder({
    required String fullName,
    required String address,
    required String phone,
    required String governorate,
    required List<CartItemEntity> items,
  }) async {
    emit(OrderPlacingState());
    try {
      final order = await repository.placeOrder(
        fullName: fullName,
        address: address,
        phone: phone,
        governorate: governorate,
        items: items,
      );
      emit(OrderPlacedState(order));
    } catch (e) {
      emit(OrderErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }

  Future<void> loadHistory() async {
    emit(OrderHistoryLoadingState());
    try {
      final orders = await repository.getOrderHistory();
      emit(OrderHistoryLoadedState(orders));
    } catch (e) {
      emit(OrderErrorState(e.toString().replaceFirst('Exception: ', '')));
    }
  }
}
