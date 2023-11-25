import 'package:chatting_app/screen/login.dart';
import 'package:chatting_app/screen/register.dart';
import 'package:flutter/material.dart';

class NavigaPage extends StatefulWidget {
  const NavigaPage({super.key});

  @override
  State<NavigaPage> createState() => _NavigaPageState();
}

class _NavigaPageState extends State<NavigaPage> {
  bool isLoginButtonPressed = false;
  bool isRegisterButtonPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Navigator Page")),
          backgroundColor: Color.fromARGB(95, 128, 76, 224)    ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            Image.asset(
              'images/413E994C-90D0-4768-AED9-337B8B9B7575.jpeg',
              fit: BoxFit.cover,
            ),
            Positioned(
              top: 200,
              left: 16,
              right: 16,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isLoginButtonPressed = !isLoginButtonPressed;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 40,
                  decoration: BoxDecoration(
                    color:  Color.fromARGB(255, 97, 123, 231),
                    borderRadius:
                        BorderRadius.circular(isLoginButtonPressed ? 20 : 10),
                    border: isLoginButtonPressed
                        ? Border.all(color: Colors.blue, width: 2)
                        : Border.all(color: Colors.black, width: 1),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.9),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Center(
                      child: Text(
                    "Login",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            Positioned(
              top: 260,
              left: 16,
              right: 16,
              child: InkWell(
                onTap: () {
                  setState(() {
                    isRegisterButtonPressed = !isRegisterButtonPressed;
                  });
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterPage()),
                  );
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: 40,
                  decoration: BoxDecoration(
                      color:Color.fromARGB(255, 97, 123, 231),
                      borderRadius: BorderRadius.circular(
                          isRegisterButtonPressed ? 20 : 10),
                      border: isRegisterButtonPressed
                          ? Border.all(color: Colors.blue, width: 2)
                          : Border.all(color: Colors.black, width: 1),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.9),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 2),
                        )
                      ]),
                  child: Center(
                      child: Text(
                    "Register",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
          ],
        ));
  }
}
