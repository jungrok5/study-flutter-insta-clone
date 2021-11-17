import 'package:flutter/material.dart';
import 'package:study_flutter_insta_clone/root_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp();
  runApp(const MyApp());
}
//https://github.com/junsuk5/flutter_insta_clon/commit/c5fc870e47e5933be9b2b40477e8ee95ef293b82
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          primaryColor: Colors.white,
          colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)
              .copyWith(secondary: Colors.black)),
      home: RootPage(),
    );
  }
}
