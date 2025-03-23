import 'package:butcher_app/repositories/auth_repository/auth_provider.dart';
import 'package:butcher_app/repositories/cart_repository/cart_repository.dart';
import 'package:butcher_app/repositories/orders_repository/order_repository.dart';
import 'package:butcher_app/repositories/wishlist_repository/wishlist_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repositories/auth_repository/auth_repository.dart';
import '../repositories/cache_repository/cache_repository.dart';
import '../repositories/checkout_repository/checkout_repository.dart';
import '../repositories/products_repository/products_provider.dart';
import '../repositories/products_repository/products_repository.dart';

class AppRepositories extends StatelessWidget {
  final Widget appBlocs;
  final FlutterSecureStorage storage;
  const AppRepositories({
    super.key,
    required this.appBlocs,
    required this.storage,
  });

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(
            storage: storage,
            authProvider: AuthProvider(
              storage: storage,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => ProductsRepository(
            provider: ProductsProvider(
              storage: storage,
            ),
          ),
        ),
        RepositoryProvider(
          create: (context) => CacheRepository(storage: storage),
        ),
        RepositoryProvider(
          create: (context) => CartRepository(secureStorage: storage),
        ),
        RepositoryProvider<CheckoutRepository>(
          create: (context) => CheckoutRepository(secureStorage: storage),
        ),
        RepositoryProvider<OrderRepository>(
          create: (context) => OrderRepository(secureStorage: storage),
        ),

        RepositoryProvider<WishlistRepository>(
  create: (context) => WishlistRepository(secureStorage: storage),
),
      ],
      child: appBlocs,
    );
  }
}
