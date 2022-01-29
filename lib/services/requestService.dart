import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class RequestService{

  String baseUrl="https://radiant-everglades-71272.herokuapp.com/requests";
  // Map<String,String> header= {'content-type': 'application/json; charset=UTF-8'};

  addRequest({product, quantity, type})async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> authHeader={'content-type': 'application/json; charset=UTF-8','authorization':'bearer '+(prefs.getString('token') as String)};
    try{
      return await http.post(
          Uri.parse(baseUrl),
          headers: authHeader,
          body: jsonEncode({
            "product": product,
            "quantity":quantity,
            "type":type
          })
      );
    }
    on SocketException{
      throw("SocketException");
    }
  }
}