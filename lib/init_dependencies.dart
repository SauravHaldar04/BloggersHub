import 'package:bloggers_hub/core/common/cubits/auth_user/auth_user_cubit.dart';
import 'package:bloggers_hub/core/common/network/check_internet_connection.dart';
import 'package:bloggers_hub/core/secrets/secrets.dart';
import 'package:bloggers_hub/features/auth/data/datasources/auth_remote_datasources.dart';
import 'package:bloggers_hub/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:bloggers_hub/features/auth/domain/repository/auth_repository.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/current_user.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/user_login.dart';
import 'package:bloggers_hub/features/auth/domain/usecases/user_signup.dart';
import 'package:bloggers_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggers_hub/features/blog/data/datasources/blog_local_datasource.dart';
import 'package:bloggers_hub/features/blog/data/datasources/blog_remote_datasource.dart';
import 'package:bloggers_hub/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:bloggers_hub/features/blog/domain/repositories/blog_repository.dart';
import 'package:bloggers_hub/features/blog/domain/usecases/get_all_blogs.dart';
import 'package:bloggers_hub/features/blog/domain/usecases/upload_blog.dart';
import 'package:bloggers_hub/features/blog/presentation/bloc/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;
Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  Hive.init((await getApplicationDocumentsDirectory()).path);
  Hive.openBox('blogs');
  final supabase = await Supabase.initialize(
    url: Secrets.supabaseUrl,
    anonKey: Secrets.supabaseAnonKey,
  );
  
  serviceLocator.registerLazySingleton(() => supabase.client);
  serviceLocator.registerLazySingleton(() => Hive.box('blogs'));
  serviceLocator.registerLazySingleton(
    () => AuthUserCubit(),
  );
  serviceLocator.registerFactory(
    () => InternetConnection(),
  );
  serviceLocator.registerFactory<CheckInternetConnection>(
    () => CheckInternetConnectionImpl(
      serviceLocator(),
    ),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDatasources>(
      () => AuthRemoteDatasourcesImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignup(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserLogin(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userLogin: serviceLocator(),
        userSignup: serviceLocator(),
        currentUser: serviceLocator(),
        authUserCubit: serviceLocator(),
      ),
    );
}

void _initBlog() {
  serviceLocator
    ..registerFactory<BlogRemoteDatasource>(
      () => BlogRemoteDatasourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogLocalDatasource>(
      () => BlogLocalDatasourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<BlogRepository>(
      () => BlogRepositoryImpl(
        serviceLocator(),
        serviceLocator(),
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UploadBlog(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => GetAllBlogs(
        serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => BlogBloc(
        uploadBlog: serviceLocator(),
        getAllBlogs: serviceLocator(),
      ),
    );
}
