import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management/ui/controllers/login_controller.dart';
import 'package:task_management/ui/screens/main_bottom_nav_screen.dart';
import 'package:task_management/ui/screens/resister_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

import '../widgets/snack_bar_message.dart';
import 'forgot_password_verify_email_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailTEController = TextEditingController();
  final TextEditingController _passwordTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final LoginController _loginController =Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 80,
                  ),
                  Text(
                    "Get Started With ",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailTEController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                    ),
                    validator: (String? value) {
                      String email = value?.trim() ?? '';
                      if (EmailValidator.validate(email) == false) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    controller: _passwordTEController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'password',
                    ),
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) || value!.length < 6) {
                        return 'Enter your password more than 6 digits';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  GetBuilder<LoginController>(
                    builder: (controller) {
                      return Visibility(
                        visible: controller.loginInProgress == false,
                        replacement: const CircularProgressIndicator(),
                        child: ElevatedButton(
                            onPressed: _onTapSingInButton,
                            child: const Icon(Icons.arrow_circle_right_outlined)),
                      );
                    }
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Center(
                    child: Column(
                      children: [
                        TextButton(
                            onPressed: _forgotPassword,
                            child: Text("Forgot Password")),
                        RichText(
                            text: TextSpan(
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: Colors.black54,
                                ),
                                children: [
                              TextSpan(text: "Don't have account? "),
                              TextSpan(
                                text: "Sing Up",
                                style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _onTapSingUpButton,
                              ),
                            ])),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSingInButton() {
    if (_formKey.currentState!.validate()) {
      _login();
    }
  }

  Future<void> _login() async {
    final bool isSuccess = await _loginController.login(
      _emailTEController.text.trim(),
      _passwordTEController.text,
    );
    if (isSuccess) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => MainBottomNavScreen()),
        (predicate) => false,
      );
    } else {
      showSnackBarMessage(context, _loginController.errorMessage!, true);
    }
  }

  void _onTapSingUpButton() {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => const ResisterScreen()));
  }

  void _forgotPassword() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => const ForgotPasswordVerifyEmailScreen()));
  }

  @override
  void dispose() {
    _emailTEController.dispose();
    _passwordTEController.dispose();
    super.dispose();
  }
}
