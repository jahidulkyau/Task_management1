import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:task_management/ui/screens/login_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() =>
      _ResetPasswordScreenState();
}

class _ResetPasswordScreenState
    extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordTEController = TextEditingController();
  final TextEditingController _confirmNewPasswordTEController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 80,
                ),
                Text(
                  "Set Password",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5,),
                Text(
                    "Create a new password minimum length of 6 later",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey
                    )
                ),
                const SizedBox(height: 5,),
               TextFormField(
                 controller: _newPasswordTEController,
                 textInputAction: TextInputAction.next,
                 decoration: InputDecoration(
                   hintText: "New Password"
                 ),
               ),
                const SizedBox(height: 5,),
                TextFormField(
                  controller: _confirmNewPasswordTEController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                      hintText: "Confirm New Password"
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed:_onTapSingInButtonAgain,
                    child: const Text("Confirm"),),
                const SizedBox(
                  height: 32,
                ),
                Center(
                  child: RichText(
                      text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          children: [
                            TextSpan(text: "Have account? "),
                            TextSpan(
                              text: "Sing In",
                              style: TextStyle(
                                  color: Colors.green, fontWeight: FontWeight.bold),
                              recognizer: TapGestureRecognizer()
                                ..onTap = _onTapSingInButton,
                            ),
                          ])),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onTapSingInButtonAgain() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()),
          (pre) => false,
    );
  }

  void _onTapSingInButton() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()),
          (pre) => false,
    );
  }
  @override
  void dispose() {

    _newPasswordTEController.dispose();
    _confirmNewPasswordTEController.dispose();

    super.dispose();
  }
}
