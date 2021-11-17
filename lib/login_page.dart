import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:study_flutter_insta_clone/tab_page.dart';

class LoginPage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Instagram Clone',
                  style: TextStyle(
                      fontSize: 40.0, fontWeight: FontWeight.bold)),
              const Padding(padding: EdgeInsets.all(50.0)),
              SignInButton(Buttons.Google, onPressed: () {
                _handleSignIn().then((user) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) =>
                          TabPage(user.user)));
                });
              })
            ],
          ),
        ));
  }

  Future<UserCredential> _handleSignIn() async {
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser!.authentication;
    var credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
