import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AttendanceService{

  String baseUrl="https://radiant-everglades-71272.herokuapp.com/attendances";
  markAttendance({longitude,latitude})async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> authHeader={'content-type': 'application/json; charset=UTF-8','authorization':'bearer '+(prefs.getString('token') as String)};
    try{
      return await http.post(
          Uri.parse(baseUrl),
          headers: authHeader,
          body: jsonEncode({
            "longitude": longitude,
            "latitude":latitude
          })
      );
    }
    on SocketException{
      throw("SocketException");
    }
  }

  getToday()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    Map<String,String> authHeader={'content-type': 'application/json; charset=UTF-8','authorization':'bearer '+(prefs.getString('token') as String)};
    try{
      return await http.get(
        Uri.parse(baseUrl+"/today"),
        headers: authHeader,
      );
    }
    on SocketException{
      throw("SocketException");
    }
  }
}