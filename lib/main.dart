import 'package:bloggers_hub/core/secrets/secrets.dart';
import 'package:bloggers_hub/core/theme/theme.dart';
import 'package:bloggers_hub/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggers_hub/features/auth/presentation/pages/sign_up_page.dart';
import 'package:bloggers_hub/init_dependencies.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bloggers Hub',
      theme: AppTheme.darkThemeMode,
      home: const SignUpPage(),
    );
  }
}
