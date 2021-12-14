import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {

  TextEditingController branch =new TextEditingController();
  TextEditingController productName =new TextEditingController();
  TextEditingController stock =new TextEditingController();
  // loadData(){
  //   return ;
  // }

  @override
  Widget build(BuildContext context) {
    return Material(
        child:
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text("Requests Report",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                  SizedBox(height: 50.0,),
                  Expanded(
                    child: ListView.separated(
                        itemCount: 30,
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
                            branch.text="Branch here";
                            productName.text="Product Name Here";
                            stock.text="2";
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
                                  ElevatedButton(onPressed: (){
                                    //api call
                                  }, child: Text("Delete"))
                                ],
                              );
                            });
                          },
                          child: ListTile(
                            leading: Text("Date"),
                            title: Center(child: Text("Product Name")),
                            subtitle: Center(child: Text("Quantity:2")),
                            trailing: Text("Demand"),
                          ));
                    }),
                  ),
                ],
              ),
            )
        //   ],
        // )
    );
  }
}
