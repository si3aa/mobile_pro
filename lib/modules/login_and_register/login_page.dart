import 'package:flutter/material.dart';
import 'package:pro/layouts/home_layout.dart';
import 'package:pro/modules/login_and_register/sign_up_page.dart';
import 'package:pro/widgets/shared.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  static String routeName = 'login';

  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
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
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    validat: (String value) {
                      if (value.isEmpty) {
                        return 'email must not be empty';
                      }
                      return null;
                    },
                    lable: 'Email',
                    prefix: Icons.email_outlined),
                const SizedBox(
                  height: 10,
                ),
                defaultFormField(
                  controller: passwordController,
                  type: TextInputType.visiblePassword,
                  validat: (String value) {
                    if (value.isEmpty) {
                      return 'email must not be empty';
                    }
                    return null;
                  },
                  lable: ' Password',
                  prefix: Icons.lock,
                  suffix: Icons.remove_red_eye,
                  isPassword: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultTextButton(
                    function: () {
                      if (formKey.currentState!.validate()) {
                        print(emailController.text);
                        print(passwordController.text);
                        Navigator.pushReplacementNamed(
                            context, HomeLayout.routeName);
                      }
                    },
                    text: 'LOGIN'),
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
        ),
      ),
    );
  }
}
