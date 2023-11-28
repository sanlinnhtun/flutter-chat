import 'package:chatting_app/screen/varify.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController pass = TextEditingController();
    bool isLoading = true;
    bool _passwordVisible = false;

    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text("Welcome to register"),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/social-media-icons-rendering (1).jpg",
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
            child: Icon(
              _passwordVisible ? Icons.visibility : Icons.visibility_off,
            ),
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
                        _passwordVisible = !_passwordVisible;
                      });
                      UserCredential newUser = await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                        email: email.text,
                        password: pass.text,
                      );
                      final user = newUser.user;
                      await user!.sendEmailVerification();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const VarifyPage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'weak-password') {
                        print('The password provided is too weak.');
                      } else if (e.code == 'email-already-in-use') {
                        print('The account already exists for that email.');
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                  child: Text('Register')))
        ],
      ),
    );
  }
}
