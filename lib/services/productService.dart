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

  getAll()async{
    try{
      return await http.get(Uri.parse(baseUrl), headers: header);
    }
    on SocketException{
      throw("SocketException");
    }
  }
}