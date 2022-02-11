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
            child: Column(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await model.signInWithGoogle();
                    Navigator.of(context).pushNamed('/');
                  },
                  child: const Text('Sign In with Google'),
                ),
                const SizedBox(height: 5),
                const Text('Or'),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () async {
                    // await model.signInWithFacebook();
                    // Navigator.of(context).pushNamed('/');
                  },
                  child: const Text('Sign In with Facebook'),
                ),
                const SizedBox(height: 5),
                const Text('Or'),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    model.signInWithPhone(context);
                  },
                  child: const Text('Sign In with Phone Number'),
                ),
                const SizedBox(height: 5),
                TextFormField(
                  controller: model.phoneController,
                  decoration: const InputDecoration(
                    hintText: 'enter phone number',
                    border: InputBorder.none,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
