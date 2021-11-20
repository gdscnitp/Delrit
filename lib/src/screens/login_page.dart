import 'package:flutter/material.dart';
import 'package:ride_sharing/provider/base_view.dart';
import 'package:ride_sharing/view/login_viewmodel.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginViewModel>(
      builder: (ctx, model, child) => Scaffold(
        body: SafeArea(
          child: Center(
            child: Container(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign In with Google'),
                  ),
                  const SizedBox(height: 5),
                  const Text('Or'),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign In with Facebook'),
                  ),
                  const SizedBox(height: 5),
                  const Text('Or'),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Sign In with Phone Number'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
