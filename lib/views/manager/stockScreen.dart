import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({Key? key}) : super(key: key);

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  TextEditingController branch =new TextEditingController();
  TextEditingController productName =new TextEditingController();
  TextEditingController stock =new TextEditingController();
  // loadData(){
  //   return ;
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text("Stock Report",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              SizedBox(height: 50.0,),
              Expanded(
                child: ListView.separated(
                  itemCount: 30,
                  separatorBuilder: (context, index) => Divider(
                        height: 15.0,
                        thickness: 2.0,
                      ),
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
                          branch.text="Branch here";
                          productName.text="Product Name Here";
                          stock.text="2";
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
                                ElevatedButton(onPressed: (){
                                  //api call
                                }, child: Text("Update"))
                              ],
                            );
                          });
                      },
                      child: ListTile(
                        leading: Text("Branch"),
                        title: Center(child: Text("Product Name")),
                        trailing: Text("Stock: 2"),
                      ));
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
