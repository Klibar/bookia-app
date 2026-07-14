import 'package:bookia/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bookia/features/auth/domain/usecases/login_usecase.dart';
import 'package:bookia/features/auth/domain/usecases/register_usecase.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/pages/splash_screen.dart';
import 'package:bookia/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:bookia/features/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/features/home/data/repositories/book_repository_impl.dart';
import 'package:bookia/features/home/domain/usecases/get_book_details_usecase.dart';
import 'package:bookia/features/home/domain/usecases/get_books_usecase.dart';
import 'package:bookia/features/home/presentation/cubit/book_cubit.dart';
import 'package:bookia/features/orders/data/repositories/order_repository_impl.dart';
import 'package:bookia/features/orders/presentation/cubit/order_cubit.dart';
import 'package:bookia/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:bookia/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepositoryImpl();
    final bookRepository = BookRepositoryImpl();
    final wishlistRepository = WishlistRepositoryImpl();
    final cartRepository = CartRepositoryImpl();
    final orderRepository = OrderRepositoryImpl();
    final profileRepository = ProfileRepositoryImpl();

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(
            loginUseCase: LoginUseCase(authRepository),
            registerUseCase: RegisterUseCase(authRepository),
          ),
        ),
        BlocProvider<BookCubit>(
          create: (_) => BookCubit(
            getBooksUseCase: GetBooksUseCase(bookRepository),
            getBookDetailsUseCase: GetBookDetailsUseCase(bookRepository),
          ),
        ),
        BlocProvider<WishlistCubit>(
          create: (_) => WishlistCubit(wishlistRepository),
        ),
        BlocProvider<CartCubit>(create: (_) => CartCubit(cartRepository)),
        BlocProvider<OrderCubit>(create: (_) => OrderCubit(orderRepository)),
        BlocProvider<ProfileCubit>(
          create: (_) => ProfileCubit(profileRepository),
        ),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        splitScreenMode: true,
        minTextAdapt: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Bookia',
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
