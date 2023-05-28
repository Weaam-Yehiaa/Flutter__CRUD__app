import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'constants.dart';

Widget defaultFormField({
  required TextEditingController? controller,
  TextInputType? type,
  Function? onChanged,
  required String label,
  FormFieldValidator<String>? valid,
}) => TextFormField(
  controller: controller,
  decoration: InputDecoration(
    focusedBorder:OutlineInputBorder(
      borderSide: BorderSide(
       color: baseColor,
      )
    ),
    labelText: label,
    labelStyle: TextStyle(
      color:Colors.grey,
    ),
    border: OutlineInputBorder(),

  ),
  keyboardType: type,
  validator: valid,
);
void showSnakeBar(BuildContext context,String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text(message)),);
}

void navigateTo(context , Widget){
  Navigator.push(
      context, MaterialPageRoute(
    builder: (context) => Widget,
  )
  );
}