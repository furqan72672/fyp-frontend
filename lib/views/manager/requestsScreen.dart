import 'package:flutter/material.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({Key? key}) : super(key: key);

  @override
  _RequestScreenState createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {


  @override
  Widget build(BuildContext context) {
    return Material(
        child: /*Column(
          children: [*/
            // Text("Requests and Demand",style: TextStyle(
            //     fontWeight: FontWeight.bold,
            //     fontSize: 25.0
            // ),),
            // SizedBox(height: 50,),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 0.0,horizontal: 10.0),
              child: ListView.separated(
                  itemCount: 30,
                  separatorBuilder: (context,index)=>Divider(height: 15.0,thickness: 2.0,),
                  itemBuilder: (context,index){
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
                      leading: Text("Date"),
                      title: Center(child: Text("Product Name")),
                      subtitle: Center(child: Text("Quantity:2")),
                      trailing: Text("Demand"),
                    ));
              }),
            )
        //   ],
        // )
    );
  }
}
