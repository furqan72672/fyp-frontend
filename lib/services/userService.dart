import 'dart:convert';
import 'dart:io';

import 'package:fyp_ims/models/signIn.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:http/http.dart' as http;

class UserService{

  String baseUrl="https://radiant-everglades-71272.herokuapp.com/users";
  Map<String,String> header= {'content-type': 'application/json; charset=UTF-8'};

  signIn({email,password})async{
    try{
      return await http.post(Uri.parse(baseUrl + '/sign-in'),
          body: jsonEncode(SignIn(email: email, password: password).toJson()),
          headers: header);
    }
    on SocketException{
      throw("SocketException");
    }
  }

  getProfile(token)async{
    Map<String,String> authHeader={'content-type': 'application/json; charset=UTF-8','authorization':'bearer '+token};
    try{
      return await http.get(Uri.parse(baseUrl + '/profile'),
          headers: authHeader);
    }
    on SocketException{
      throw("SocketException");
    }
    on Exception{
      throw(Exception);
    }
  }

  signUp(User user)async{
    try{
      return await http.post(Uri.parse(baseUrl + '/signup'),
          body: jsonEncode(user.toJson()),
          headers: header);
    }
    on SocketException{
      throw("SocketException");
    }
    on Exception{
      throw(Exception);
    }
  }
}