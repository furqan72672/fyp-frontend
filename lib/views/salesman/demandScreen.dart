import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/models/product.dart';
import 'package:fyp_ims/services/productService.dart';
import 'package:fyp_ims/services/requestService.dart';

class DemandScreen extends StatefulWidget {
  const DemandScreen({Key? key}) : super(key: key);

  @override
  _DemandScreenState createState() => _DemandScreenState();
}

class _DemandScreenState extends State<DemandScreen> {

  int quantity=0;
  var barcode;
  Product? product;
  TextEditingController nameController=new TextEditingController();
  TextEditingController barcodeController=new TextEditingController();
  var formkey=GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode= AutovalidateMode.disabled;
  bool quantityError=false;

  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      barcode=await barcodeScanRes;
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
    if(int.parse(barcode)==-1||barcode==null) return;
    var res=await ProductService().getBarcode(barcode);
    var decoded=jsonDecode(res.body);
    product=Product.fromJson(decoded);
    setState(() {
      nameController.text=product!.name;
      barcodeController.text=product!.barcode;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

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
              Form(
                key: formkey,
                autovalidateMode: _autovalidateMode,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: nameController,
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
                    TextFormField(
                      controller: barcodeController,
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
                      validator: (val){
                        if(val=='') {
                          return "Barcode can not be empty";
                        }
                      },
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
                    quantityError?Row(
                      children: [
                        Text("Quantity can not be 0", style: TextStyle(color: Colors.red),),
                      ],
                    ):SizedBox(),
                    SizedBox(height: 50.0,),
                    Text("OR",),
                    Text("Scan BarCode",style: TextStyle(fontSize: 25),),
                    IconButton(icon:Icon(CupertinoIcons.barcode,size: 50,),onPressed: ()async{
                      await scanBarcodeNormal();
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(barcode.toString()),));
                    },),
                    Padding(
                      padding: const EdgeInsets.all(50.0),
                      child: Container(
                          height: 50.0,
                          width: double.infinity,
                          child: ElevatedButton(onPressed: ()async{
                            if(!formkey.currentState!.validate()){
                              _autovalidateMode=AutovalidateMode.always;
                              setState(() {});
                              return;
                            }
                            if(quantity==0){
                              quantityError=true;
                              setState(() {});
                              return;
                            }
                            quantityError=false;
                            setState(() {});
                            CustomDialog().show(text: "Creating Demand...",context: context);
                            var res=await RequestService().addRequest(product: barcodeController.text,quantity: quantity,type: 0);
                            var decoded=jsonDecode(res!.body);
                            CustomDialog().notShow(context);
                            barcodeController.text="";
                            nameController.text="";
                            quantity=0;
                            _autovalidateMode=AutovalidateMode.disabled;
                            setState(() {});
                            if(decoded['_id']==null) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(decoded['error'])));
                              return;
                            }
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Demand Created")));
                          }, child: Text("Demand Product",style: TextStyle(fontWeight: FontWeight.bold),))),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
