import 'package:bookia/core/theme/app_colors.dart';
import 'package:bookia/features/auth/domain/entities/user_entity.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_state.dart';
import 'package:bookia/features/cart/presentation/pages/cart_page.dart';
import 'package:bookia/features/home/presentation/pages/home_page.dart';
import 'package:bookia/features/profile/presentation/pages/profile_page.dart';
import 'package:bookia/features/wishlist/presentation/pages/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Hosts the four main tabs of the app (matches the bottom nav bar shown
/// on the Home / Wishlist / Cart / Profile mockups). This is what the user
/// lands on right after Login / Register.
class MainShell extends StatefulWidget {
  final UserEntity user;

  const MainShell({super.key, required this.user});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;
  late final UserEntity _user = widget.user;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(user: _user),
      const WishlistPage(),
      const CartPage(),
      ProfilePage(user: _user),
    ];

    return Scaffold(
      body: IndexedStack(index: _index, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.gold,
        unselectedItemColor: AppColors.hintGray,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'Wishlist',
          ),
          BottomNavigationBarItem(
            icon: BlocBuilder<CartCubit, CartState>(
              builder: (context, state) {
                return Badge(
                  isLabelVisible: state.itemCount > 0,
                  label: Text('${state.itemCount}'),
                  child: const Icon(Icons.shopping_cart_outlined),
                );
              },
            ),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
