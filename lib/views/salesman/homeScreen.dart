import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:fyp_ims/services/attendanceService.dart';
import 'package:fyp_ims/utils/geoFunctions.dart';
import 'package:fyp_ims/utils/timeFormatter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  User user;
  bool attendanceInfo;
  HomeScreen({Key? key,required this.user,required this.attendanceInfo}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  bool show = true;
  bool attendance = false;
  String formattedDate = DateFormat('dd-MM-yyyy').format(DateTime.now());
  TimeOfDay time = TimeOfDay.now();
  Timer? timer;
  Position? pos;
  late User user=widget.user;
  var disableAttendance=null;
  bool resolved=false;

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) {
      if (time.minute != TimeOfDay
          .now()
          .minute)
        setState(() {
          time = TimeOfDay.now();
        });
    });
  }

  void checkAttendance()async{
    // var res=await AttendanceService().getToday();
    // var decoded=jsonDecode(res!.body);
    if(widget.attendanceInfo){
      disableAttendance=null;
    }
    else{
      disableAttendance=() async {
        CustomDialog().show(context: context,text: "Getting location data...");
        try {
          pos=null;
          pos=await GeoFunctions().determinePosition();
          print(pos);
          String? location;
          try{
            List<Placemark> placemark = await placemarkFromCoordinates(pos!.latitude ,pos!.longitude);
            location="Your location is "+(placemark[0].name as String)+", "+(placemark[0].street as String)+", "+(placemark[0].subLocality as String)+", "+(placemark[0].locality as String)+", "+(placemark[0].administrativeArea as String)+", "+(placemark[0].country as String)+". Do you want to mark attendance here?";
          }
          on PlatformException{
            CustomDialog().notShow(context);
            location="Your coordinates are "+pos!.latitude.toString()+pos!.longitude.toString()+". Do you want to mark attendance here?";
          }
          showDialog(context: context, builder: (ctx){
            return AlertDialog(
              actions: [
                ElevatedButton(onPressed: (){
                  Navigator.of(context).pop();
                }, child: Text("Cancel")),
                ElevatedButton(onPressed: ()async{
                  Navigator.pop(context);
                  CustomDialog().show(text: "Marking Attendance...",context: context);
                  var res=await AttendanceService().markAttendance(latitude: pos!.latitude,longitude: pos!.longitude);
                  var decoded=jsonDecode(res!.body);
                  print(decoded);
                  if (decoded['_id'] != null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Attendance marked"),
                      duration: Duration(seconds: 2),
                    ));
                  } else if(decoded['message']!=null) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(decoded['message']),
                      duration: Duration(seconds: 2),
                    ));
                  }
                  else{
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(decoded['error']),
                      duration: Duration(seconds: 2),
                    ));
                  }
                  CustomDialog().notShow(context);
                }, child: Text("Yes")),
              ],
              content: Text(location as String),
            );
          });
          // CustomDialog().showConfirmation(context: context,text: location,confirmText: "Yes",cancelText: "Cancel");
        }
        catch (e) {
          if (e == '1') {
            CustomDialog().notShow(context);
            _showAlert("Location Disabled",
                "Location services are disabled. Would you like to enable them?",e.toString());
          }//
          else if(e=='Location permissions are denied'){
            CustomDialog().notShow(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Attendance not marked because location permissions were denied"),duration: Duration(seconds: 2),));
          }
          else if(e=='2'){
            CustomDialog().notShow(context);
            _showAlert("Location permanently denied", "Location permissions are permanently denied, we cannot request permissions. Would you like to go to App Settings?", e.toString());
          }
          else{
            CustomDialog().notShow(context);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),duration: Duration(seconds: 2),));
            print(e);
          }
        }
      };
    }
    resolved=true;
  }

  _showAlert(String title, String content, String e) {
    return showDialog(context: context, builder: (ctx) {
      return Center(
        child: AlertDialog(
          content: Text(content),
          title: Text(title),
          actions: [
            ElevatedButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("No")),
            ElevatedButton(onPressed: ()async{
              if (e == '1') {
                await Geolocator.openLocationSettings();
              }
              else if(e =='2'){
                await Geolocator.openAppSettings();
              }
              Navigator.of(context).pop();
            }, child: Text("Yes")),
          ],
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    checkAttendance();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                //handle this
                child: Text("Hi "+this.user.name.toString()[0].toUpperCase()+this.user.name.toString().substring(1), style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold
                ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(formattedDate,
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                        ),),
                       Text( TimeFormatter().formatTime(),
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),)
                    ],
                  ),
                  Spacer(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                          width: 120.0, height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            //handle this
                            child: Text("Incentive: "+"500",
                              style: TextStyle(
                                  color: Colors.white,
                              ),),
                          ))),
                      SizedBox(height: 20.0,),
                      Container(
                          width: 120.0, height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            //handle this
                            child: Text("Target: "+this.user.target.toString(), style: TextStyle(
                                color: Colors.white,
                            )),
                          )))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 100.0,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Column(
                  children: [
                    Container(
                      height: 50.0,
                      width: double.infinity,
                      child: ElevatedButton(
                        child: Text(!widget.attendanceInfo?"Mark Attendance":"Attendance already marked",style: TextStyle(fontWeight: FontWeight.bold)),
                        onPressed: disableAttendance
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }
}
