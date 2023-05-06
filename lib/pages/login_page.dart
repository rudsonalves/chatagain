import 'package:flutter/material.dart';

import '../components/large_button.dart';
import '../common/sign_validator.dart';
import '../components/custom_text_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({
    super.key,
  });

  static const routeName = '/login';

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordCheckController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool isLogin = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        title: const Text('Chat login'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(10),
          children: [
            Text(
              'Welcome Back!',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w900,
                  color: Theme.of(context).colorScheme.secondary),
            ),
            CunstomTextField(
              label: 'Email',
              controller: _emailController,
              validator: SignValidator.validateEmail,
            ),
            CunstomTextField(
              label: 'Password',
              controller: _passwordController,
              obscureText: true,
              suffixIcon: Icons.visibility,
              validator: SignValidator.validatePassword,
            ),
            if (!isLogin)
              CunstomTextField(
                label: 'Check Password',
                controller: _passwordCheckController,
                obscureText: true,
                suffixIcon: Icons.visibility_off,
                validator: (newPassword) {
                  if (newPassword != null) {
                    return SignValidator.validateConfirmPassword(
                        _passwordController.text, newPassword);
                  }
                  return null;
                },
              ),
            LargeButton(
              label: isLogin ? 'Login' : 'Sign In',
              image: isLogin ? null : 'assets/images/email_logo.png',
              onPressed: () {
                final bool valit = _formKey.currentState != null &&
                    _formKey.currentState!.validate();

                if (valit) {
                  debugPrint('Dados validado!');
                } else {
                  debugPrint('Dados não validados!');
                }
              },
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  isLogin = !isLogin;
                  debugPrint(isLogin.toString());
                });
              },
              child: Text(
                isLogin
                    ? 'Already have account? Sign in'
                    : 'Don’t have Account? Sign up',
              ),
            ),
            LargeButton(
              label: 'Gmail',
              image: 'assets/images/gmail_logo.png',
              onPressed: () {
                debugPrint('Login with Gmail');
              },
            ),
          ],
        ),
      ),
    );
  }
}
