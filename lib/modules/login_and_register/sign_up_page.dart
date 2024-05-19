import 'package:flutter/material.dart';
import 'package:pro/widgets/shared.dart';

class SignUpPage extends StatefulWidget {
  static String routeName = 'register';

  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();

  final _passwordController = TextEditingController();

  final _confirmPasswordController = TextEditingController();

  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: const Text(
          'Register',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const Row(
                  children: [
                    Text(
                      'SIGN UP',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                defaultFormField(
                  controller: _emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  lable: 'Email',
                  type: TextInputType.emailAddress,
                  prefix: Icons.email,
                ),
                const SizedBox(height: 16.0),
                defaultFormField(
                  isPassword: isPassword,
                  controller: _passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }

                    return null;
                  },
                  lable: 'Password',
                  type: TextInputType.visiblePassword,
                  prefix: Icons.lock,
                   suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                   suffixPressed: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }
                ),
                const SizedBox(height: 16.0),
                defaultFormField(
                   isPassword: isPassword,
                    lable: 'Confirm Password',
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                    type: TextInputType.visiblePassword,
                    prefix: Icons.lock,
                   
                    suffix: isPassword ? Icons.visibility : Icons.visibility_off,
                    suffixPressed: () {
                        setState(() {
                          isPassword =!isPassword;
                        });
                      }
                    ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Registering...'),
                        ),
                      );
                      Navigator.pop(context);
                    }
                  },
                  child: CustomButton(
                    text: 'Sign Up',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
