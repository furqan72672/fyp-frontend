import 'package:flutter/material.dart';

class SalesScreen extends StatefulWidget {
  const SalesScreen({Key? key}) : super(key: key);

  @override
  _SalesScreenState createState() => _SalesScreenState();
}

class _SalesScreenState extends State<SalesScreen> {

  // List<TableRow> data=[];
  // createRows(){
  //   data.add(TableRow(
  //       decoration: BoxDecoration(color: Colors.grey.shade200),
  //       children: [
  //         Center(child: Text("Salesman")),
  //         Center(child: Text("Branch")),
  //         Center(child: Text("Sales")),
  //         Center(child: Text("Target")),
  //         Center(child: Text("incentive")),
  //       ]
  //   ));
  //   for(var i=1;i<=10;i++){
  //     data.add(TableRow(
  //         children: [
  //           Center(child: Text("1")),
  //           Center(child: Text("1")),
  //           Center(child: Text("1")),
  //           Center(child: Text("1")),
  //           Center(child: Text("1")),
  //         ]
  //     ));
  //   }
  // }
  @override
  void initState() {
    // TODO: implement initState
    // createRows();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Sales Report",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 50.0,),
              Expanded(
                child: ListView.separated(
                    itemCount: 15,
                    separatorBuilder: (context,index)=>Divider(height: 15.0,thickness: 2.0,),
                    itemBuilder: (context,index){
                      return ListTile(
                        isThreeLine: true,
                        leading: Text("Branch"),
                        title: Center(child: Text("Salesman Name")),
                        subtitle: Column(
                        children: [
                          Center(child: Text("Target: 50")),
                          Center(child: Text("Incentive: 50")),
                        ],
                      ),
                        trailing: Text("Sales: 10"),
                      );
                    }),
              ),
            ],
          ),
        )
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
