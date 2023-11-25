import 'package:chatting_app/screen/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VarifyPage extends StatefulWidget {
  const VarifyPage({super.key});

  @override
  State<VarifyPage> createState() => _VarifyPageState();
}

class _VarifyPageState extends State<VarifyPage> {
  // final currentUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text("Welcom to Varification page"),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            "images/DD1DB157-1625-49BB-996C-09660A7ECBF0.jpeg",
            fit: BoxFit.cover,
          ),
          const Positioned(
              top: 50,
              left: 16,
              right: 16,
              child: Text(
                  "Account varification, Varify your email address blah blah blah...")),
          Positioned(
              top: 100,
              left: 90,
              right: 90,
              child: ElevatedButton(
                  onPressed: () async {
                    User? currentUser = FirebaseAuth.instance.currentUser;
                    await currentUser!.reload();
                    currentUser = FirebaseAuth.instance.currentUser;
                    if (currentUser!.emailVerified == true) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()),
                      );
                    } else {
                      print("Show error message");
                    }
                  },
                  child: const Text(
                    "varify by eamail",
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )))
        ],
      ),
    );
  }
}
