import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/features/orders/domain/entities/order_entity.dart';
import 'package:bookia/features/orders/presentation/cubit/order_cubit.dart';
import 'package:bookia/features/orders/presentation/cubit/order_state.dart';
import 'package:bookia/features/orders/presentation/pages/order_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrderCubit>().loadHistory();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: const BackButton(color: AppColors.textDark),
        title: const Text(
          'My Orders',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocBuilder<OrderCubit, OrderState>(
        builder: (context, state) {
          if (state is OrderHistoryLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          final orders =
              state is OrderHistoryLoadedState ? state.orders : <OrderEntity>[];
          if (orders.isEmpty) {
            return const Center(
              child: Text('No orders yet',
                  style: TextStyle(color: AppColors.hintGray)),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(20),
            itemCount: orders.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final order = orders[i];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => OrderDetailsPage(order: order),
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order No${order.orderNumber.replaceFirst('#', '')}',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textDark,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${order.date.day.toString().padLeft(2, '0')}/'
                            '${order.date.month.toString().padLeft(2, '0')}/'
                            '${order.date.year}',
                            style: const TextStyle(
                              color: AppColors.hintGray,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Total Amount: \$${order.total.toStringAsFixed(0)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: AppColors.textDark,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
