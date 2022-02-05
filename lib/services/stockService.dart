import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class StockService{

  String baseUrl="https://radiant-everglades-71272.herokuapp.com/stocks";
  // Map<String,String> header= {'content-type': 'application/json; charset=UTF-8'};

  getAll()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> authHeader={'content-type': 'application/json; charset=UTF-8','authorization':'bearer '+(prefs.getString('token') as String)};
    try{
      return await http.get(
        Uri.parse(baseUrl),
        headers: authHeader,
      );
    }
    on SocketException{
      throw("SocketException");
    }
  }

  update(id,quantity)async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> authHeader={'content-type': 'application/json; charset=UTF-8','authorization':'bearer '+(prefs.getString('token') as String)};
    Map<String,dynamic> upd={'quantity': quantity};

    try{
      return await http.patch(
        Uri.parse(baseUrl+'/'+id),
        headers: authHeader,
        body: jsonEncode(upd)
      );
    }
    on SocketException{
      throw("SocketException");
    }
  }
}