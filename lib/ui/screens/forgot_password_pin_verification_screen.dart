import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_management/ui/screens/login_screen.dart';
import 'package:task_management/ui/screens/reset_password_screen.dart';
import 'package:task_management/ui/widgets/screen_background.dart';

class ForgotPasswordPinVerificationScreen extends StatefulWidget {
  const ForgotPasswordPinVerificationScreen({super.key});

  @override
  State<ForgotPasswordPinVerificationScreen> createState() =>
      _ForgotPasswordPinVerificationScreenState();
}

class _ForgotPasswordPinVerificationScreenState
    extends State<ForgotPasswordPinVerificationScreen> {
  final TextEditingController _pinTEController = TextEditingController();
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
                  "Pin Verification",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 5,),
                Text(
                    "A 6 digit verification pin has been send to your email address",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.grey
                    )
                ),
                PinCodeTextField(
                  keyboardType: TextInputType.number,
                  length: 6,
                  obscureText: false,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedFillColor: Colors.white,
                    inactiveFillColor: Colors.white,
                  ),
                  animationDuration: Duration(milliseconds: 300),
                  backgroundColor: Colors.transparent,
                  enableActiveFill: true,

                  controller: _pinTEController,
                 appContext: context,

                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    onPressed:_onTapSubmitButton,
                    child: const Text("Verify"),),
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


  void _onTapSubmitButton(){

    Navigator.push(context, MaterialPageRoute(builder: (context)=> ResetPasswordScreen(),),);
  }

  void _onTapSingInButton() {
   Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=> const LoginScreen()),
     (pre) => false,
   );
  }
  @override
  void dispose() {
    _pinTEController.dispose();
    super.dispose();
  }
}
