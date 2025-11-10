
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(child: Text("HELLO IN HOME PAGE "),),
    );}
}
/*
Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            final user = FirebaseAuth.instance;
            user.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => AuthChoicePage()),
            );
          },
          child: Text("press to log out"),
        ),
      ),
    );
  
 */