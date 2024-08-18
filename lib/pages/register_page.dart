import 'package:chat/services/auth/auth_service.dart';
import 'package:chat/components/my_button.dart';
import 'package:chat/components/my_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _pwController = TextEditingController();
  final TextEditingController _confirmPwController = TextEditingController();

  final void Function()? onTap;

  RegisterPage({
    super.key,
    required this.onTap,
  });

  // register method

  void register( BuildContext context) {
    // get auth service
    final _auth = AuthService();

    // passwords match -> create user
    if (_pwController.text == _confirmPwController.text) {
      try {
        _auth.signUpWithEmailPassword(
          _emailController.text, 
          _pwController.text,
        );
      } catch (e) {
        showDialog(
          context: context, 
          builder: (context) => AlertDialog(
            title: Text(e.toString()),
          ),
        );
      }
    }

    // passwords not match -> show error to user
    else {
      showDialog(
          context: context, 
          builder: (context) => const AlertDialog(
            title: Text("パスワードが間違っています。"),
          ),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.power,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),

            const SizedBox(height: 50),

            // welcome message
            Text(
              "アカウントを登録してください。",
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 25),

            // email textfield
            MyTextField(
              hintText: "メールアドレス",
              obscureText: false,
              controller: _emailController,
            ),

            const SizedBox(height: 10),

            // pw textfield
            MyTextField(
              hintText: "パスワード",
              obscureText: true,
              controller: _pwController,
            ),

            const SizedBox(height: 10),

            // confirm pw textfield
            MyTextField(
              hintText: "確認用パスワード",
              obscureText: true,
              controller: _confirmPwController,
            ),
            const SizedBox(height: 25),

            // loginbutton
            Mybutton(
              text: "アカウント登録",
              onTap: () => register(context),
            ),

            const SizedBox(height: 25),

            // register now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "既にアカウントを登録していますか？",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Text(
                    "ログイン",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
