import 'package:chatting_app/screen/chat.dart';
// import 'package:chatting_app/screen/chatting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isLoading = true;
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Welcom to login page"),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/35C94846-6DC5-4C92-BA45-AE2D44EBEF37.jpeg",
            fit: BoxFit.cover,
          ),
          Positioned(
            top: 100,
            left: 10,
            right: 10,
            child: TextField(
              controller: email,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 10,
            right: 10,
            child: TextField(
              controller: pass,
              decoration: InputDecoration(
                labelText: 'Password',
                hintText: 'Enter your password',
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _passwordVisible = !_passwordVisible;
                    });
                  },
                  child: Icon(_passwordVisible
                      ? Icons.visibility
                      : Icons.visibility_off),
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
              ),
              obscureText: _passwordVisible,
            ),
          ),
          Positioned(
              top: 275,
              left: 80,
              right: 80,
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      setState(() {
                        isLoading = false;
                        _passwordVisible = !_passwordVisible;
                      });
                      UserCredential newUser = await FirebaseAuth.instance
                          .signInWithEmailAndPassword(
                        email: email.text,
                        password: pass.text,
                      );
                      final user = newUser.user;
                      await user!.sendEmailVerification();
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ChattingPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        debugPrint('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        debugPrint('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: const Text('Login')))
        ],
      ),
    );
  }
}
