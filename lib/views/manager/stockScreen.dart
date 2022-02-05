import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/models/stock.dart';
import 'package:fyp_ims/services/stockService.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  TextEditingController branch =new TextEditingController();
  TextEditingController productName =new TextEditingController();
  TextEditingController stock =new TextEditingController();
  List<Stock> localData=[];
  var refreshKey=GlobalKey<RefreshIndicatorState>();

  Future<void> loadData()async{
    refreshKey.currentState?.show();
    localData=[];
    var res=await StockService().getAll();
    var decoded=jsonDecode(res!.body);
    decoded.forEach((stock)async{
      localData.add(Stock.fromJson(stock));
    });
    if(mounted){
      setState(() {});
    }
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: localData.length!=0?Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Stock Report",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 50.0,),
              Expanded(
                child: RefreshIndicator(
                  key: refreshKey,
                  onRefresh: loadData,
                  color: Colors.indigo,
                  child: ListView.separated(
                    itemCount: localData.length,
                    separatorBuilder: (context, index) => Divider(height: 15.0,thickness: 2.0,),
                    itemBuilder: (context, index) {
                    return Dismissible(
                        direction: DismissDirection.startToEnd,
                        key: UniqueKey(),
                        background: Container(
                          alignment: AlignmentDirectional.centerStart,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                            child: Text(
                              "Update",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17.0,
                                  // fontWeight: FontWeight.bold),
                            ),),
                          ),
                        ),
                        onDismissed: (direction) {
                            branch.text=localData[index].branch.store_name;
                            productName.text=localData[index].product.name;
                            stock.text=localData[index].quantity.toString();
                            showDialog(barrierDismissible: false,context: context, builder: (ctx){
                              return AlertDialog(
                                title: Center(child: Text("Update Stock", style: TextStyle(fontWeight: FontWeight.bold),)),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextField(controller:branch,readOnly: true),
                                    TextField(controller:productName,readOnly: true),
                                    TextField(controller:stock),
                                  ],
                                ),
                                actions: [
                                  ElevatedButton(onPressed: (){
                                    Navigator.of(context).pop();
                                    setState(() {});
                                    }, child: Text("Cancel")),
                                  ElevatedButton(onPressed: ()async{
                                    CustomDialog().show(text: "Updating. Please Wait",context: context);
                                    var res=await StockService().update(localData[index].id,int.parse(stock.text));
                                    // print(res);
                                    var decoded=jsonDecode(res!.body);
                                    if(decoded['_id']==null){
                                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong while updating. Please try later."),duration: Duration(seconds: 2),));
                                      setState(() {});
                                    }
                                    else{
                                      refreshKey.currentState?.show();
                                    }
                                    CustomDialog().notShow(context);
                                    Navigator.pop(context);
                                  }, child: Text("Update"))
                                ],
                              );
                            });
                        },
                        child: ListTile(
                          leading: Text(localData[index].branch.store_name),
                          title: Center(child: Text(localData[index].product.name)),
                          trailing: Text("Stock: "+localData[index].quantity.toString()),
                        ));
                  }),
                ),
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator(),)
    );
  }
}
