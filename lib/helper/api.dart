import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:rise_up_task/shared/components.dart';
import 'package:rise_up_task/shared/constants.dart';

class Api {
  Map<String, String>headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "Bearer ${token}",
  };

  Future<dynamic> post({
    required String url,
    required dynamic body,
    required BuildContext context,
  }) async {
    http.Response response = await http.post(
        Uri.parse(url),
        body: body,
        headers: headers
    );
    int code = response.statusCode;
    String e="";
    if (code == 201) {
      showSnakeBar(context, 'User is added successfully ');

      print(response.body);
      Map<String, dynamic>data = jsonDecode(response.body);

      return data;
    }
    else {
      if(code==404)
      {
        e="The requested resource does not exist.";
      }
      else if(code==415)
      {
        e=": Unsupported media type. The requested content type or version number is invalid.";
      }
      else if(code==500)
      {
        e="Internal server error.";
      }

      showSnakeBar(context, 'Something is error, ${e} ');
      throw Exception(
          'this is a problem in status code ${response.statusCode}'
      );
    }
  }

  Future<dynamic> get(String url1, String url2) async {
    var uri = Uri.https(url1, url2);
    String e="";
    http.Response response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      if(response.statusCode==404)
      {
        e="The requested resource does not exist.";
      }
      else if(response.statusCode==415)
      {
        e=": Unsupported media type. The requested content type or version number is invalid.";
      }
      else if(response.statusCode==500)
      {
        e="Internal server error.";
      }

      print( 'Something is error,   ${e} ');

      throw Exception(

          'this is a problem in status code ${response.statusCode}'
      );
    }
  }

  Future<int> delete(int id) async {
    final url = 'https://gorest.co.in/public/v2/users/${id}';
    final uri = Uri.parse(url);
    http.Response response = await http.delete(uri, headers: headers);
    return response.statusCode;
  }

  Future<void> update(int id,String body) async {
    final url = 'https://gorest.co.in/public/v2/users/${id}';
    final uri = Uri.parse(url);
    String e="";
    http.Response response = await http.put(uri, body: body, headers: headers);
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      if(response.statusCode==404)
      {
        e="The requested resource does not exist.";
      }
      else if(response.statusCode==415)
      {
        e=": Unsupported media type. The requested content type or version number is invalid.";
      }
      else if(response.statusCode==500)
      {
        e="Internal server error.";
      }

      print( 'Something is error,  ${e} ');
      throw Exception(

          'this is a problem in status code ${response.statusCode}'
      );
    }
  }
}