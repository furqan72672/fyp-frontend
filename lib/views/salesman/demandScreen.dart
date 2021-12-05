import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class DemandScreen extends StatefulWidget {
  const DemandScreen({Key? key}) : super(key: key);

  @override
  _DemandScreenState createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> {

  int quantity=0;
  String _scanBarcode = 'Unknown';
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      print(_scanBarcode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("Create A Product Demand",
                style: TextStyle(
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold
                ),
              ),
              SizedBox(height: 100.0,),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextField(
                    decoration: InputDecoration(
                        label: Text("Product Name"),
                        border: OutlineInputBorder(),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon:Icon(Icons.search),onPressed: (){},),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  TextField(
                    decoration: InputDecoration(
                        label: Text("Product Code"),
                        border: OutlineInputBorder(),
                        suffixIcon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(icon:Icon(Icons.add_to_photos_rounded),onPressed: (){},),
                          ],
                        )
                    ),
                  ),
                  SizedBox(height: 25.0,),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("Quantity",style: TextStyle(fontSize: 20.0)),
                      Spacer(),
                      IconButton(onPressed: (){
                        if(quantity>0){
                          --quantity;
                        }
                        setState(() {});
                      }, icon: Icon(Icons.remove,size:30.0)),
                      Container(width:40.0,height: 40.0,decoration:BoxDecoration(color: Colors.grey.shade100),child: Center(child: Text(quantity.toString(),style: TextStyle(fontWeight: FontWeight.bold,fontSize: 30.0),))),
                      IconButton(onPressed: (){
                        ++quantity;
                        setState(() {});
                      }, icon: Icon(Icons.add,size: 30.0,)),
                    ],
                  ),
                  SizedBox(height: 50.0,),
                  Text("OR",),
                  Text("Scan BarCode",style: TextStyle(fontSize: 25),),
                  IconButton(icon:Icon(Icons.camera_alt,size: 30,),onPressed: (){
                    scanBarcodeNormal();
                  },),
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Container(
                        height: 50.0,
                        width: double.infinity,
                        child: ElevatedButton(onPressed: (){}, child: Text("Demand Product",style: TextStyle(fontWeight: FontWeight.bold),))),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
