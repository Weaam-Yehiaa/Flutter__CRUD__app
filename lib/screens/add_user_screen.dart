import 'dart:convert';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:rise_up_task/helper/api.dart';
import 'package:rise_up_task/models/user_model.dart';
import 'package:rise_up_task/screens/list_of_users_screen.dart';
import 'package:rise_up_task/shared/components.dart';

import '../shared/constants.dart';

class AddUserScreen extends StatefulWidget {

  UserModel? userEdit;

  AddUserScreen( {this.userEdit});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  TextEditingController nameController=TextEditingController();

  TextEditingController emailController=TextEditingController();

  TextEditingController genderController=TextEditingController();

  TextEditingController statusController=TextEditingController();

  bool edit=false;

  bool loading=true;

  var formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    if(widget.userEdit!=null)
    {
      final name=widget.userEdit!.name;
      final email=widget.userEdit!.email;
      final status=widget.userEdit!.status;
      final gender=widget.userEdit!.gender;
      nameController.text=name;
      emailController.text=email;
      genderController.text=gender;
      statusController.text=status;
      edit=true;
    }

    Future<void>addUser() async {
      String name=nameController!.text;
      String email=emailController!.text;
      String status=statusController!.text;
      String gender=genderController!.text;
      final String url="https://gorest.co.in/public/v2/users";
      final body = jsonEncode({
        "name":name ,
        "email":email ,
        "status":status ,
        "gender":gender,
      });
      Api().post(url: url, body: body,context:context);
      setState(() {
        loading=false;
      });
      navigateTo(context, ListOfUsers());

    }
    Future<void>updateUser() async {
      String name=nameController!.text;
      String email=emailController!.text;
      String status=statusController!.text;
      String gender=genderController!.text;
      print(widget.userEdit!.email);
      if(widget.userEdit==null)
        {
          print('No edit user can\'t delete');
          return;
        }
      final body=jsonEncode({
        'name':name,
        'email':email,
        'gender':gender,
        'status':status,
      });
      print(body);
      Api().update(widget.userEdit!.id, body);
      setState(() {
        loading=false;
      });
      navigateTo(context, ListOfUsers());

    }


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: baseColor,
          title: Text(
           edit? 'Edit':' Add User ',
          ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(
              children: [
                defaultFormField(
                    controller: nameController,
                    type: TextInputType.name,
                    label: ' Name ',
                    valid:(value) {
                      if (value!.isEmpty)
                        return 'Enter your Name';
                    },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: ' Email ',
                    valid:(value) {
                      if (value!.isEmpty)
                        return 'Enter your Email';
                    },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller:genderController ,
                    label: ' Gender ',
                  valid:(value) {
                    if (value!.isEmpty)
                      return 'Enter your Gender';
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                defaultFormField(
                    controller: statusController,
                    label: ' Status ',
                  valid:(value) {
                    if (value!.isEmpty)
                      return 'Enter your Status';
                  },
                ),
                SizedBox(
                  height: 100.0,
                ),

                ConditionalBuilder(
                  condition: loading,
                  builder: (context) =>MaterialButton(
                    color: baseColor,
                    height: 50.0,
                    minWidth: double.infinity,
                      onPressed: (){
                      if(formkey.currentState!.validate())
                         edit?updateUser() :addUser();
                        //navigateTo(context, ListOfUsers());
                      },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.w500,
                      ),

                    ),
                  ),
                  fallback: (context) => Center(child: CircularProgressIndicator(color: baseColor,)),
                )
              ],
            ),
          ),
        ),
      ),


    );
  }
}
