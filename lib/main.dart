import 'package:bloggers_hub/core/secrets/secrets.dart';
import 'package:bloggers_hub/core/theme/theme.dart';
import 'package:bloggers_hub/features/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: Secrets.supabaseUrl,
    anonKey:Secrets.supabaseAnonKey,
  );
  runApp(const MyApp());
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
