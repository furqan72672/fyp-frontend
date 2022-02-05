import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/models/request.dart';
import 'package:fyp_ims/services/requestService.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  TextEditingController branch =new TextEditingController();
  TextEditingController productName =new TextEditingController();
  TextEditingController stock =new TextEditingController();
  List<Request> localData=[];
  var refreshKey=GlobalKey<RefreshIndicatorState>();

  Future<void> loadData()async{
    refreshKey.currentState?.show();
    localData=[];
    var res=await RequestService().getAll();
    var decoded=jsonDecode(res!.body);
    decoded.forEach((request)async{
      localData.add(Request.fromJson(request));
    });
    if(mounted){
      setState(() {});
    }
  }
  
  format(String i){
    return i.substring(0,10);
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child:
            localData.length>0?Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Requests Report",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(height: 50.0,),
                  Expanded(
                    child: RefreshIndicator(
                      key: refreshKey,
                      onRefresh: loadData,
                      child: ListView.separated(
                          itemCount: localData.length,
                          separatorBuilder: (context,index)=>Divider(height: 15.0,thickness: 2.0,),
                          itemBuilder: (context,index){
                        return Dismissible(
                          direction: DismissDirection.endToStart,
                            key: UniqueKey(),
                            background: Container(
                              alignment: AlignmentDirectional.centerEnd,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0.0, 0, 15.0, 0),
                                child: Text(
                                  "Delete",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17.0,
                                    // fontWeight: FontWeight.bold),
                                  ),),
                              ),
                            ),
                            onDismissed: (direction) {
                              showDialog(barrierDismissible: false,context: context, builder: (ctx){
                                return AlertDialog(
                                  title: Center(child: Text("Delete Request", style: TextStyle(fontWeight: FontWeight.bold),)),
                                  content:
                                      Text("Are you sure you want to delete the selected request? The action may be irreversible.",textAlign: TextAlign.center,),
                                  actions: [
                                    ElevatedButton(onPressed: (){
                                      Navigator.of(context).pop();
                                      setState(() {});
                                    }, child: Text("Cancel")),
                                    ElevatedButton(onPressed: ()async{
                                      CustomDialog().show(text: "Deleting. Please Wait",context: context);
                                      var res=await RequestService().delete(localData[index].id);
                                      var decoded=jsonDecode(res!.body);
                                      if(decoded['deleted']==null){
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong while updating. Please try later."),duration: Duration(seconds: 2),));
                                        // setState(() {});
                                      }
                                      else{
                                        refreshKey.currentState?.show();
                                      }
                                      CustomDialog().notShow(context);
                                      Navigator.pop(context);
                                    }, child: Text("Delete"))
                                  ],
                                );
                              });
                            },
                            child: ListTile(
                              isThreeLine: true,
                              leading: Text(format(localData[index].createdAt)),
                              title: Center(child: Text(localData[index].product.name,textAlign: TextAlign.center,)),
                              subtitle: Center(child: Column(
                                children: [
                                  Text("Quantity:"+localData[index].quantity.toString()),
                                  Text(localData[index].user.branch![0].store_name),
                                ],
                              )),
                              trailing: Text(localData[index].type==0?"Demand":"Replace"),

                            ));
                      }),
                    ),
                  ),
                ],
              ),
            ):Center(child: CircularProgressIndicator(),),
    );
  }
}
