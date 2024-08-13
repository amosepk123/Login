
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';


import 'auth_service.dart';
import 'login1.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  bool _isButtonVisible = false;



  void _validateForm() {
    setState(() {
      _isButtonVisible = _formkey.currentState?.validate() ?? false;
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              const Spacer(),
              const Text(
                "Signup",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 50),
              TextFormField(
                controller: _name,
                decoration:  InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'please enter the name';
                  }
                  else if (value.length < 3) {
                    return 'Password must be at least 6 characters long';
                  }
                },
                onChanged: (value) {
                  _validateForm();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _email,
                decoration:  InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (input){
                  final emailRegExp=RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                  if(!emailRegExp.hasMatch(input!)){
                    return "Enter the Valid MailID";
                  }
                  //return null;
                },
                onChanged: (value) {

                },
                onFieldSubmitted: (value){
                  _validateForm();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _password,
                obscureText: true,
                decoration:  InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value){
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  } else if (value.length < 6) {
                    return 'Password must be at least 6 characters long';
                  }
                  return null;
                },
                onChanged: (value) {
                  _validateForm();
                },
              ),
              const SizedBox(height: 20),
              _isButtonVisible
                  ? ElevatedButton(
                onPressed: (){
                  if (_formkey.currentState!.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("ok Success")));
                  }
                  _signup();

                },
                child: const Text("Signup"),
              )
                  :  GestureDetector(
                  onTap:(){
                    showDialog(context: context, builder: (BuildContext context){
                      return AlertDialog(
                        title: Text("Enter the Details correctly"),
                      );
                    });
                  },
                child: Text("Signup"),
                  ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account? "),
                  InkWell(
                    onTap: () => goToLogin(context),
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  void goToLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  // void goToHome(BuildContext context) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => const HomeScreen()),
  //   );
  // }

  Future<void> _signup() async {
    try {
      await _auth.createUserWithEmailAndPassword(
        _email.text,
        _password.text,
      );
      Navigator.of(context).pop();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("$e")),
      );
      print(e); // Handle the error appropriately
    }
  }

}
