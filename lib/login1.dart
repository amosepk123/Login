
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'signup1.dart';
import 'home.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = AuthService();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final phoneController = TextEditingController();

  bool isLoading = false;

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          children: [
             Spacer(),
             Text(
              "Login",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
            ),
             SizedBox(height: 50),
            TextFormField(
              controller: _email,
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Enter Email",
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: _password,
              obscureText: true,
              decoration:  InputDecoration(
                labelText: "Password",
                hintText: "Enter Password",
              ),
            ),
             SizedBox(height: 30),
            ElevatedButton(
              onPressed: _login,
              child: Text("Login"),
            ),
            SizedBox( height: 5,),

            ElevatedButton(onPressed: () async {
              await _auth.loginWithGoogle();
              Navigator.push(context, MaterialPageRoute(builder: (context)=> HomeScreen()));
            }, child: Text("sign in Google")),


            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account? "),
                InkWell(
                  onTap: () => goToSignup(context),
                  child: const Text("Signup", style: TextStyle(color: Colors.red),),
                ),
              ],
            ),
            Spacer(),


          ],
        ),
      ),
    );
  }

  void goToSignup(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SignupScreen()),
    );
  }

  // void goToHome(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const HomeScreen()),
  //   );
  // }

  Future<void> _login() async {
   await _auth.loginUserWithEmailAndPassword(
      _email.text,
      _password.text,
    );

    // if (user != null) {
    //   log("User Logged In");
    //   goToHome(context);
    // }
  }
}
