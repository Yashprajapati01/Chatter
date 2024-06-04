import 'package:chatter/auth/LoginorRegister.dart';
import 'package:chatter/pages/login_page.dart';
import 'package:chatter/pages/Home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot){
          //user is loogedin or not
          if(snapshot.hasData){
            return HomePage();
          }
          else {
            return const LoginorRegister();
          }
        }
      ),
    );
  }
}
