import 'package:college_alert_app/Screens/Auth/signup_screen.dart';
import 'package:college_alert_app/Screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; //Firebase Auth import

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool changeButton = false;
  final _formkey = GlobalKey<FormState>();

  // Firebase Auth controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> moveToHome() async {
    if (_formkey.currentState?.validate() ?? false) {
      setState(() {
        changeButton = true;
      });

      // Firebase login code
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        await Future.delayed(const Duration(milliseconds: 300));
        if (!mounted) return;

        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (e) {
        String message = '';
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided.';
        } else {
          message = e.message ?? 'Something went wrong';
        }

        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      } finally {
        setState(() {
          changeButton = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: GestureDetector(
           onTap: () {
        FocusScope.of(context).unfocus(); // keyboard close on outside tap
      },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFFFDF9), Color(0xFFF3EBDD), Color(0xFFE8DCC8)],
              ),
            ),
            child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(), // Important
              child: Form(
                key: _formkey,
                child: Column(
                  children: [
                    const SizedBox(height: 100),
                    const Text(
                      "College Alert System",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF5A3A1E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Stay updated with campus events",
                      style: TextStyle(color: Color(0xFF8A7F72)),
                    ),
                    const SizedBox(height: 50),
          
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Card(
                        elevation: 8,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Column(
                            children: [
                              const Text(
                                "Welcome",
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF5A3A1E),
                                ),
                              ),
                              const SizedBox(height: 30),
          
                              // Email field
                              TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.email),
                                  labelText: "Email",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email cannot be empty";
                                  }
                                  if (!value.contains("@")) {
                                    return "Enter a valid email";
                                  }
                                  return null;
                                },
                              ),
          
                              const SizedBox(height: 20),
          
                              // Password field
                              TextFormField(
                                controller: passwordController,
                                obscureText: true,
                                decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.lock),
                                  labelText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password cannot be empty";
                                  }
                                  if (value.length < 6) {
                                    return "Password should be at least 6 characters";
                                  }
                                  return null;
                                },
                              ),
          
                              const SizedBox(height: 30),
          
                              // Login Button
                              Material(
                                color: const Color(0xFF5A3A1E),
                                borderRadius: BorderRadius.circular(
                                  changeButton ? 50 : 14,
                                ),
                                child: InkWell(
                                  onTap: moveToHome,
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    width: changeButton
                                        ? 50
                                        : MediaQuery.of(context).size.width - 48,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF5A3A1E),
                                      borderRadius: BorderRadius.circular(
                                        changeButton ? 50 : 14,
                                      ),
                                    ),
                                    child: changeButton
                                        ? const Icon(
                                            Icons.done,
                                            color: Colors.white,
                                          )
                                        : const Text(
                                            "Login",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                  ),
                                ),
                              ),
          
                              const SizedBox(height: 20),
          
                              // Signup link
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text("Don't have an account? "),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const SignupScreen(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Sign up",
                                      style: TextStyle(
                                        color: Color(0xFF5A3A1E),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
          
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
