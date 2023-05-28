import 'package:flutter/material.dart';
import 'package:rise_up_task/screens/add_user_screen.dart';
import 'package:rise_up_task/screens/list_of_users_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    debugShowCheckedModeBanner: false,
      home:ListOfUsers(),
    );
  }
}

