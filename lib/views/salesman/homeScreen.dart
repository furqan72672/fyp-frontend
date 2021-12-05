import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fyp_ims/utils/geoFunctions.dart';
import 'package:fyp_ims/utils/timeFormatter.dart';
import 'package:geocoding/geocoding.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

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
                child: Text("Hi Dummy", style: TextStyle(
                    fontSize: 20,
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
                          width: 100.0, height: 100.0,
                          decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            //handle this
                            child: Text("Your incentive earned is Dummy Data",
                              style: TextStyle(
                                  color: Colors.white
                              ),),
                          ))),
                      SizedBox(height: 20.0,),
                      Container(
                          width: 100.0, height: 100.0,
                          decoration: BoxDecoration(
                            color: Colors.indigoAccent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Center(child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            //handle this
                            child: Text("Pieces left to sell", style: TextStyle(
                                color: Colors.white
                            )),
                          )))
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.0,),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(50.0),
                child: Container(
                  height: 50.0,
                  width: double.infinity,
                  child: ElevatedButton(
                    child: Text("Mark Attendance",style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () async {
                      try {
                        pos=await GeoFunctions().determinePosition();
                      }
                      catch (e) {
                        if (e == '1') {
                          _showAlert("Location Disabled",
                              "Location services are disabled. Would you like to enable them?",e.toString());
                        }//
                        else if(e=='Location permissions are denied'){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Attendance not marked because location permissions were denied"),duration: Duration(seconds: 2),));
                        }
                        else if(e=='2'){
                          _showAlert("Location permanently denied", "Location permissions are permanently denied, we cannot request permissions. Would you like to go to App Settings?", e.toString());
                        }
                      }
                      //handle this
                      List<Placemark> placemark = await placemarkFromCoordinates(pos!.latitude, pos!.longitude);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your placemark is "+(placemark[0].name as String)+", "+(placemark[0].street as String)+", "+(placemark[0].subLocality as String)+", "+(placemark[0].locality as String)+", "+(placemark[0].administrativeArea as String)+", "+(placemark[0].country as String)),duration: Duration(seconds: 2),));
                      // print(placemark);

                    },
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    timer!.cancel();
  }
}
