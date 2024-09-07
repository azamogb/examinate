import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home1 extends StatelessWidget {
   Home1({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signOut(){

    FirebaseAuth.instance.signOut();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: signOut, icon: const Icon(Icons.logout))],

      ),
      body: Center(
        child: Text('start ${user.email!}'),
      ),
    );
  }
}
