import 'package:flutter/material.dart';
import 'package:pro/widgets/shared.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static String routeName = 'register';
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
                  'SIGN Up',
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
            CustomButton(
              text: 'SIGN IN',
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Already have an Account',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    '  LOGIN',
                    style: TextStyle(
                      color: Color(0xffC7EDE6),
                    ),
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
