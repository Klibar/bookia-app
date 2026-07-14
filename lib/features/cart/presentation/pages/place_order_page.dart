import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/pages/order_success_page.dart';
import 'package:bookia/features/cart/presentation/widgets/governorate_selector.dart';
import 'package:bookia/features/orders/presentation/cubit/order_cubit.dart';
import 'package:bookia/features/orders/presentation/cubit/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaceOrderPage extends StatefulWidget {
  const PlaceOrderPage({super.key});

  @override
  State<PlaceOrderPage> createState() => _PlaceOrderPageState();
}

class _PlaceOrderPageState extends State<PlaceOrderPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _governorate;

  @override
  void dispose() {
    _nameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickGovernorate() async {
    final result = await showGovernorateSelector(context);
    if (result != null) setState(() => _governorate = result);
  }

  void _submit(BuildContext context) {
    if (!_formKey.currentState!.validate()) return;
    if (_governorate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a governorate')),
      );
      return;
    }
    final items = context.read<CartCubit>().state.items;
    context.read<OrderCubit>().placeOrder(
          fullName: _nameController.text.trim(),
          address: _addressController.text.trim(),
          phone: _phoneController.text.trim(),
          governorate: _governorate!,
          items: items,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: BlocListener<OrderCubit, OrderState>(
          listener: (context, state) {
            if (state is OrderPlacedState) {
              context.read<CartCubit>().clear();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const OrderSuccessPage()),
              );
            } else if (state is OrderErrorState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => Navigator.maybePop(context),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.arrow_back_ios_new, size: 18),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Place Your Order',
                    style: TextStyle(
                      fontFamily: 'Georgia',
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textDark,
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    "Don't worry! It occurs. Please enter the email "
                    'address linked with your account.',
                    style: TextStyle(color: AppColors.hintGray, fontSize: 13),
                  ),
                  const SizedBox(height: 24),
                  _field(_nameController, 'Full Name'),
                  const SizedBox(height: 14),
                  _field(_addressController, 'Address'),
                  const SizedBox(height: 14),
                  _field(_phoneController, 'Phone',
                      keyboardType: TextInputType.phone),
                  const SizedBox(height: 14),
                  GestureDetector(
                    onTap: _pickGovernorate,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _governorate ?? 'Governorate',
                            style: TextStyle(
                              color: _governorate == null
                                  ? const Color(0xFF9B9B9B)
                                  : AppColors.textDark,
                              fontSize: 15,
                            ),
                          ),
                          const Icon(Icons.keyboard_arrow_down,
                              color: AppColors.hintGray),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 28),
                  BlocBuilder<CartCubit, CartState>(
                    builder: (context, state) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total:',
                            style: TextStyle(
                                fontSize: 16, color: AppColors.hintGray),
                          ),
                          Text(
                            '\$${state.total.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textDark,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  BlocBuilder<OrderCubit, OrderState>(
                    builder: (context, state) {
                      final isLoading = state is OrderPlacingState;
                      return SizedBox(
                        width: double.infinity,
                        height: 54,
                        child: ElevatedButton(
                          onPressed:
                              isLoading ? null : () => _submit(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.gold,
                            disabledBackgroundColor:
                                AppColors.gold.withOpacity(0.6),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: isLoading
                              ? const SizedBox(
                                  width: 22,
                                  height: 22,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2.5,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text(
                                  'Submit Order',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String hint,
      {TextInputType? keyboardType}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? '$hint is required' : null,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Color(0xFF9B9B9B), fontSize: 15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
      ),
    );
  }
}
