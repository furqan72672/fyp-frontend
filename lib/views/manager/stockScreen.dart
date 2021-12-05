import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
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
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      child: ListView.separated(
          itemCount: 30,
          separatorBuilder: (context, index) => Divider(
                height: 15.0,
                thickness: 2.0,
              ),
          itemBuilder: (context, index) {
            return Dismissible(
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
                secondaryBackground: Container(
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
                  if(direction==DismissDirection.endToStart){
                    //Delete
                  }
                  else{
                    //update
                  }
                },
                child: ListTile(
                  leading: Text("Branch"),
                  title: Center(child: Text("Product Name")),
                  trailing: Text("Stock: 2"),
                ));
          }),
    )
        // Padding(
        //   padding: const EdgeInsets.all(20.0),
        //   child: Column(
        //     mainAxisAlignment: MainAxisAlignment.spaceAround,
        //     children: [
        //       Text("Stock Report",style: TextStyle(
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
