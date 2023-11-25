import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChattingPage extends StatefulWidget {
  const ChattingPage({super.key});

  @override
  State<ChattingPage> createState() => _ChattingPageState();
}

class _ChattingPageState extends State<ChattingPage> {
  TextEditingController msg = TextEditingController();
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  User? currentUser;

  @override
  void initState() {
    super.initState();
    getUser();
    // getDataFromFirestore();
  }

  getUser() {
    setState(() {
      currentUser = auth.currentUser;
    });
  }

  // getDataFromFirestore() async {
  //   // GET DATA ONLY ONCE
  //   var mydata = await firestore.collection('flutterchat').get();
  //   for (var message in mydata.docs) {
  //     print(message.data());
  //   }
  // }
  //   print(">>>>>>>>>>>>>>>>>>>");
  //   // GET DATA with STREAM - Snapshots
  //   await for (var snapshot
  //       in firestore.collection('flutterchat').snapshots()) {
  //     for (var message in snapshot.docs) {
  //       print(message.data());
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            "Messenger",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 36, 78, 108),
      ),
      body: Column(
        children: [
          StreamBuilder(
            stream: firestore.collection('gameroom').orderBy('timestamp', descending: true).snapshots(),
            builder: (context, snapshot) {
              List<Widget> messageList = [];
              if (snapshot.hasData) {
                for (var message in snapshot.data!.docs) {
                  bool isCurrentUser = currentUser!.email == message['sender'];
                  messageList.add(
                    Row(
                      mainAxisAlignment: isCurrentUser
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: isCurrentUser ? Colors.blue : Colors.grey,
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Text(
                            "${message['message']}",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }
              return Expanded(
                child: ListView(
                  reverse: true,
                  children: messageList,
                ),
              );
            },
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: SizedBox(
              width: 400,
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: TextField(
                  controller: msg,
                  decoration: InputDecoration(
                    hintText: 'Type your message...',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: IconButton(
                      onPressed: () async {
                        try {
                          await firestore.collection("gameroom").add(
                            {
                              "sender": currentUser!.email,
                              "message": msg.text,
                              "timestamp": FieldValue.serverTimestamp(),
                            },
                          );
                          msg.clear();
                        } catch (e) {
                          print(e);
                        }
                      },
                      icon: const Icon(
                        Icons.telegram_outlined,
                        size: 40,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class MessageBubble extends StatelessWidget {
//   const MessageBubble({super.key, required this.sender, required this.message});
//   final String sender;
//   final String message;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.end,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [],
//         )
//       ],
//     );
//   }
// }
