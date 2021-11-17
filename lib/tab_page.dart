import 'package:flutter/material.dart';
import 'package:study_flutter_insta_clone/account_page.dart';
import 'package:study_flutter_insta_clone/home_page.dart';
import 'package:study_flutter_insta_clone/search_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class TabPage extends StatefulWidget {
  final User? user;

  //const TabPage({Key? key, this.user}) : super(key: key);
  TabPage(this.user);

  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 0;

  List? _pages;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pages = [
      HomePage(widget.user),
      SearchPage(widget.user),
      AccountPage(widget.user)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: _pages![_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        fixedColor: Colors.black,
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle), label: 'Account'),
        ],
      ),
    );
  }

  void _onItemTapped(int value) {
    setState(() {
      _selectedIndex = value;
    });
  }
}
