import 'package:bloc/bloc.dart';
import 'package:butcher_app/state/bloc/auth_bloc/auth_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/cache_repository/cache_repository.dart';
import '../../../static/app_strings.dart';

part 'cache_event.dart';
part 'cache_state.dart';

class CacheBloc extends Bloc<CacheEvent, CacheState> {
  final CacheRepository cacheRepository;
  final AuthBloc authBloc;
  CacheBloc({
    required this.cacheRepository,
    required this.authBloc,

  }) : super(CacheInitialState()) {

    on<AppStarted>((event, emit) async {
      emit(CacheLoadingState());
      try {
        if (await cacheRepository.hasAuthenticationToken()) {
          authBloc.add(AuthenticateFromCache());
        } else {
          emit(CacheNotFoundState());
        }
      } catch (e) {
        emit(
          const CacheErrorState(
            message: AppStrings.errorMessage,
          ),
        );
      }
    });
  }
}
