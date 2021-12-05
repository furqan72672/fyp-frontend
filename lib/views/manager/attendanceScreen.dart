import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  _AttendanceScreenState createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {

  // List<TableRow> data=[];
  // createRows(){
  //   data.add(TableRow(
  //       decoration: BoxDecoration(color: Colors.grey.shade200),
  //       children: [
  //         Center(child: Text("Product")),
  //         Center(child: Text("Stock")),
  //         Center(child: Text("Branch")),
  //       ]
  //   ));
  //   for(var i=1;i<=10;i++){
  //     data.add(TableRow(
  //         children: [
  //           Center(child: Text("Random Product")),
  //           Center(child: Text("1")),
  //           Center(child: Text("Random Store")),
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
        child:Padding(
          padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
          child: ListView.separated(
              itemCount: 30,
              separatorBuilder: (context,index)=>Divider(height: 15.0,thickness: 2.0,),
              itemBuilder: (context,index){
                return ListTile(
                  leading: Text("Time"),
                  title: Center(child: Text("Salesman Name")),
                  subtitle: Center(child: Text("Branch")),
                  trailing: Text("Present"),
                );
              }),
        )
        // Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Text("Attendance",style: TextStyle(
        //           fontWeight: FontWeight.bold,
        //           fontSize: 25.0
        //       ),),
        //       SizedBox(height: 50,),
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
