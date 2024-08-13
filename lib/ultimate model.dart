import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'auth_service.dart';
import 'login1.dart';

class corrected_model extends StatefulWidget {
  const corrected_model({super.key});

  @override
  State<corrected_model> createState() => _corrected_modelState();
}

class _corrected_modelState extends State<corrected_model> {
  final _auth = AuthService();

  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formkey = GlobalKey<FormState>();

  final FocusNode _nameFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  bool _isButtonVisible = false;
  bool _nameTouched = false;
  bool _emailTouched = false;
  bool _passwordTouched = false;

  @override
  void initState() {
    super.initState();

    // Add listeners to FocusNodes to track when fields are touched
    _nameFocusNode.addListener(() {
      if (!_nameFocusNode.hasFocus) {
        setState(() {
          _nameTouched = true;
        });
        _validateForm();
      }
    });

    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        setState(() {
          _emailTouched = true;
        });
        _validateForm();
      }
    });

    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        setState(() {
          _passwordTouched = true;
        });
        _validateForm();
      }
    });
  }

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
    _nameFocusNode.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
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
                focusNode: _nameFocusNode,
                decoration: InputDecoration(
                  labelText: "Name",
                  hintText: "Enter Name",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (_nameTouched) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else if (value.length < 3) {
                      return 'Name must be at least 3 characters long';
                    }
                  }
                  return null;
                },
                onChanged: (value) {
                  _validateForm();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _email,
                focusNode: _emailFocusNode,
                decoration: InputDecoration(
                  labelText: "Email",
                  hintText: "Enter Email",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (input) {
                  if (_emailTouched) {
                    final emailRegExp = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegExp.hasMatch(input!)) {
                      return "Enter a valid Email ID";
                    }
                  }
                  return null;
                },
                onChanged: (value) {
                  _validateForm();
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _password,
                focusNode: _passwordFocusNode,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Enter Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                validator: (value) {
                  if (_passwordTouched) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
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
                onPressed: () {
                  if (_formkey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Signup Success")));
                  }
                  _signup();
                },
                child: const Text("Signup"),
              )
                  : GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Enter the Details First"),
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
