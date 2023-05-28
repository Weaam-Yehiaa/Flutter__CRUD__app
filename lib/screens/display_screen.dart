import 'package:flutter/material.dart';
import 'package:rise_up_task/models/user_model.dart';
import 'package:rise_up_task/shared/constants.dart';

class DisplayScreen extends StatelessWidget {

  UserModel user;

  DisplayScreen({required this.user}); //const DisplayScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: baseColor,
        title: Text('User\'s Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
                'Name : ${user.name} ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),

            ),
            Divider(
              height: 20.0,
            ),
            Text(
                'Email : ${user.email} ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              height: 20.0,
            ),
            Text(
                'Gender : ${user.gender} ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
            Divider(
              height: 20.0,
            ),
            Text(
                'Status : ${user.status} ',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),

    );
  }
}
