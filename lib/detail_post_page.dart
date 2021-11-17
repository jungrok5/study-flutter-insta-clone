import 'package:flutter/material.dart';

class DetailPostPage extends StatelessWidget {
  final dynamic document;

  DetailPostPage(this.document);

  //const DetailPostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('둘러보기'),
      ),
      body: _buildBody(),
    );
  }

  _buildBody() {
    return SafeArea(
        child: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(document['userPhotoUrl']),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          document['email'],
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(document['displayName'])
                      ],
                    )),
              ],
            ),
          ),
          Hero(
              tag: document['photoUrl'],
              child: Image.network(document['photoUrl'])),
          Padding(
              padding: EdgeInsets.all(8.0), child: Text(document['contents']))
        ],
      ),
    ));
  }
}
