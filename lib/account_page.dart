import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AccountPage extends StatefulWidget {
  final User? user;

  AccountPage(this.user);
  //const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  int _postCount = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance.collection('post').where('email', isEqualTo: widget.user!.email)
    .get().then((snapshot) {
      setState(() {
        _postCount = snapshot.docs.length;
      });
    });
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            _googleSignIn.signOut();
          },
          icon: Icon(Icons.exit_to_app),
          color: Colors.black,
        ),
      ],
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    width: 80.0,
                    height: 80.0,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          widget.user!.photoURL!),
                    ),
                  ),
                  Container(
                    width: 80.0,
                    height: 80.0,
                    alignment: Alignment.bottomRight,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 28.0,
                          height: 28.0,
                          child: FloatingActionButton(
                            onPressed: () => {},
                            backgroundColor: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 25.0,
                          height: 25.0,
                          child: FloatingActionButton(
                            onPressed: () => {},
                            backgroundColor: Colors.blue,
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
              Padding(padding: EdgeInsets.all(8.0)),
              Text(
                widget.user!.displayName!,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0),
              )
            ],
          ),
          Text(
            '$_postCount\n게시물',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            '0\n팔로워',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
          Text(
            '0\n팔로잉',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
