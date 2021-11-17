import 'package:flutter/material.dart';
import 'package:study_flutter_insta_clone/login_page.dart';
import 'package:study_flutter_insta_clone/tab_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RootPage extends StatelessWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
      if (snapshot.hasData) {
        return TabPage(snapshot.data);
      } else {
        return LoginPage();
      }
    },);
  }
}
