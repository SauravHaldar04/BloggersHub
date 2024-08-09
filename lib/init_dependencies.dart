import 'package:bloggers_hub/core/secrets/secrets.dart';
import 'package:bloggers_hub/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:bloggers_hub/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloggers_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/user_login.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/user_signup.dart';
import 'package:bloggers_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: Secrets.supabaseUrl,
    anonKey: Secrets.supabaseAnonKey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  serviceLocator.registerFactory<AuthRemoteDatasources>(
    () => AuthRemoteDatasourcesImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserSignup(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory(
    () => UserLogin(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userLogin: serviceLocator(),
      userSignup: serviceLocator(),
    ),
  );
}
