import 'dart:io';
import 'package:http/http.dart' as http;

class ProductService{

  String baseUrl="https://radiant-everglades-71272.herokuapp.com/products";
  Map<String,String> header= {'content-type': 'application/json; charset=UTF-8'};

  getBarcode(barcode)async{
    try{
      return await http.get(Uri.parse(baseUrl + '/barcode/'+barcode.toString()), headers: header);
    }
    on SocketException{
      throw("SocketException");
    }
  }

//   getProfile(token)async{
//     Map<String,String> authHeader={'content-type': 'application/json; charset=UTF-8','authorization':'bearer '+token};
//     try{
//       return await http.get(Uri.parse(baseUrl + '/profile'),
//           headers: authHeader);
//     }
//     on SocketException{
//       throw("SocketException");
//     }
//     on Exception{
//       throw(Exception);
//     }
//   }
//
//   signUp(User user)async{
//     try{
//       return await http.post(Uri.parse(baseUrl + '/signup'),
//           body: jsonEncode(user.toJson()),
//           headers: header);
//     }
//     on SocketException{
//       throw("SocketException");
//     }
//     on Exception{
//       throw(Exception);
//     }
//   }
}