import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pro/layouts/home_layout.dart';
import 'package:pro/modules/login_and_register/sign_up_page.dart';
import 'package:pro/widgets/shared.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  static String routeName = 'login';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            const Spacer(flex: 2),
            const Row(
              children: [
                Text(
                  'SIGN IN',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              hintText: 'Email',
            ),
            const SizedBox(
              height: 10,
            ),
            CustomTextField(
              hintText: 'Password',
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () => Navigator.pushNamed(context, HomeLayout.routeName),
              child: CustomButton(
                text: 'LOGIN',
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Don\'t have an account ?',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, SignUpPage.routeName);
                  },
                  child: const Text(
                    '  Sign UP',
                    style: TextStyle(color: Color(0xffC7EDE6)),
                  ),
                )
              ],
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
