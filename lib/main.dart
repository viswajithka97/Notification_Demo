import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notification/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String title = "No Tittle";
  String body = "No Body";
  String data = "No Data";

  @override
  void initState() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotification();
    firebaseMessaging.streamCtrl.stream.listen(_changeData);
    firebaseMessaging.tittleCtrl.stream.listen(_changeTitle);
    firebaseMessaging.bodyCtrl.stream.listen(_changeBody);
    super.initState();
  }

  _changeData(String msg) => setState(() => data = msg);
  _changeTitle(String msg) => setState(() => title = msg);
  _changeBody(String msg) => setState(() => body = msg);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "title : $title",
            ),
            Text(
              "body : $body",
            ),
            Text(
              "data : $data",
            ),
          ],
        ),
      ),
    );
  }
}
