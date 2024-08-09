import 'package:bloggers_hub/core/common/cubits/auth_user/auth_user_cubit.dart';
import 'package:bloggers_hub/core/theme/theme.dart';
import 'package:bloggers_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggers_hub/features/auth/presentation/pages/login_page.dart';
import 'package:bloggers_hub/features/auth/presentation/pages/sign_up_page.dart';
import 'package:bloggers_hub/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as sb;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthUserCubit>()),
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
    super.initState();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloggers Hub',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<AuthUserCubit, AuthUserState, bool>(
        selector: (state) {
          return state is AuthUserLoggedIn;
        },
        builder: (context, state) {
          if (state) {
            return const Scaffold(
              body: Center(
                child: Text("Home Page"),
              ),
            );
          }
          return const LoginPage();
        },
      ),
    );
  }
}
