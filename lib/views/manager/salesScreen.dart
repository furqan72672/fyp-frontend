import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/models/sale.dart';
import 'package:fyp_ims/services/saleService.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {

  List<Sale> localData=[];
  var refreshKey=GlobalKey<RefreshIndicatorState>();

  Future<void> loadData()async{
    refreshKey.currentState?.show();
    localData=[];
    var res=await SaleService().getAll();
    var decoded=jsonDecode(res!.body);
    decoded.forEach((sale)async{
      localData.add(Sale.fromJson(sale));
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
              Text("Sales Report",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 50.0,),
              Expanded(
                child: RefreshIndicator(
                  key: refreshKey,
                  color: Colors.indigo,
                  onRefresh: loadData,
                  child: ListView.separated(
                      itemCount: localData.length,
                      separatorBuilder: (context,index)=>Divider(height: 15.0,thickness: 2.0,),
                      itemBuilder: (context,index){
                        return ListTile(
                          isThreeLine: true,
                          leading: Text(localData[index].user.branch![0].store_name),
                          title: Center(child: Text(localData[0].user.name)),
                          subtitle: Column(
                          children: [
                            Center(child: Text("Target: 50")),
                            Center(child: Text("Incentive: 50")),
                          ],
                        ),
                          trailing: Text(localData[0].sold.toString()),
                        );
                      }),
                ),
              ),
            ],
          ),
        ):Center(child: CircularProgressIndicator())
        // Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Text("Sales Report",style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 25.0
        //       ),),
        //       // SizedBox(height: 50,),
        //       Table(
        //         border: TableBorder.all(),
        //         children: data,
        //       ),
        //     ],
        //   ),
        // )
    );
  }
}
