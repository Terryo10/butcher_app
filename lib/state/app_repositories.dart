import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../repositories/auth_repository/auth_repository.dart';
import '../repositories/cache_repository/cache_repository.dart';
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
          create: (context) => AuthRepository(),
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
        )
      ],
      child: appBlocs,
    );
  }
}
