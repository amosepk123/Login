import 'package:flutter/material.dart';
import 'auth_service.dart';


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthService();
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome User",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await auth.signout();
                //goToLogin(context);
              },
              child: const Text("Sign Out"),
            ),

          ],
        ),
      ),
    );
  }

  // void goToLogin(BuildContext context) {
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(builder: (context) => const LoginScreen()),
  //         (route) => false,
  //   );
  // }
}
