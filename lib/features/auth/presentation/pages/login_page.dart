import 'package:bloggers_hub/core/theme/app_pallete.dart';
import 'package:bloggers_hub/features/auth/presentation/pages/sign_up_page.dart';
import 'package:bloggers_hub/features/auth/presentation/widgets/auth_gradient.dart';
import 'package:bloggers_hub/features/auth/presentation/widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static route() => MaterialPageRoute(builder: (context) => const LoginPage());
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
    formKey.currentState!.validate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Sign In.',
                style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomField(hintText: 'Email', controller: emailController),
              const SizedBox(
                height: 15,
              ),
              CustomField(
                hintText: 'Password',
                controller: passwordController,
                isObscure: true,
              ),
              const SizedBox(
                height: 15,
              ),
              AuthGradientButtonn(
                buttonText: 'Sign In',
                onPressed: () async {},
              ),
              const SizedBox(
                height: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, SignUpPage.route());
                },
                child: RichText(
                  text: TextSpan(
                      text: 'Don\'t have an account? ',
                      style: Theme.of(context).textTheme.titleMedium,
                      children: const <TextSpan>[
                        TextSpan(
                          text: 'Sign Up',
                          style: TextStyle(
                              color: Pallete.gradient2,
                              fontWeight: FontWeight.bold),
                        )
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
