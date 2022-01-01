import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/models/address.dart';
import 'package:fyp_ims/models/shift.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:fyp_ims/services/userService.dart';
import 'package:fyp_ims/views/auth/landing_page.dart';


class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController nameController= new TextEditingController();
  TextEditingController emailController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  TextEditingController passwordController2= new TextEditingController();
  TextEditingController toController= new TextEditingController();
  TextEditingController fromController= new TextEditingController();
  TextEditingController line1Controller= new TextEditingController();
  TextEditingController line2Controller= new TextEditingController();
  TextEditingController cityController= new TextEditingController();
  TextEditingController stateController= new TextEditingController();
  TextEditingController countryController= new TextEditingController();
  TextEditingController zipController= new TextEditingController();
  TextEditingController visaController= new TextEditingController();
  TextEditingController phoneController= new TextEditingController();


  var formkey=GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode= AutovalidateMode.disabled;
  bool show=true;
  bool show2=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text="Flutter";
    emailController.text="flutter@test.com";
    passwordController.text="123456789";
    passwordController2.text="123456789";
    toController.text= "16";
    fromController.text= "8";
    line1Controller.text="house no. 11, abc";
    line2Controller.text="def,ghi";
    cityController.text="lahore";
    stateController.text="punjab";
    countryController.text="pakistan";
    zipController.text="56400";
    visaController.text="112247821";
    phoneController.text="03229482969";
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign up as a new user"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Form(
              key: formkey,
              autovalidateMode: _autovalidateMode,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Personal",style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        label: Text("Name*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "Name can not be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        label: Text("Email*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "Email can not be empty";
                        }
                        if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val as String)){
                          return "Not a valid email format";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      keyboardType: TextInputType.phone,
                      controller: phoneController,
                      decoration: InputDecoration(
                        label: Text("Phone Number"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: visaController,
                      decoration: InputDecoration(
                        label: Text("Visa*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "Visa can not be empty";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text("Shift",style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: fromController,
                      decoration: InputDecoration(
                        label: Text("From*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "From can not be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: toController,
                      decoration: InputDecoration(
                        label: Text("To*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "To can not be empty";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text("Address",style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(

                      controller: line1Controller,
                      decoration: InputDecoration(
                        label: Text("Line 1*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "Line 1 can not be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      controller: line2Controller,
                      decoration: InputDecoration(
                        label: Text("Line 2"),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      controller: cityController,
                      decoration: InputDecoration(
                        label: Text("City*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "City can not be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      controller: stateController,
                      decoration: InputDecoration(
                        label: Text("State*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "State 1 can not be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      controller: countryController,
                      decoration: InputDecoration(
                        label: Text("Country*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "Country can not be empty";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: zipController,
                      decoration: InputDecoration(
                        label: Text("ZIP code*"),
                      ),
                      validator: (val){
                        if(val=='') {
                          return "Zip Code can not be empty";
                        }
                      },
                    ),
                  ),
                  SizedBox(height: 25,),
                  Text("Password",style: TextStyle(fontWeight: FontWeight.bold),),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: show,
                      decoration: InputDecoration(
                          label: Text("Password*"),
                          suffixIcon: IconButton(onPressed: (){
                            show=!show;
                            setState(() {});
                          },icon: show?Icon(Icons.remove_red_eye_sharp):Icon(Icons.remove_red_eye_outlined),)
                      ),
                      validator: (val){
                        if(val=='') {
                          return "Password can not be empty";
                        }
                        if(val!.length<8){
                          return "Password length must be at least 8 characters";
                        }
                        if(val!=passwordController2.text) {
                          return "Password does not match";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20,0,0,0),
                    child: TextFormField(
                      controller: passwordController2,
                      obscureText: show2,
                      decoration: InputDecoration(
                          label: Text("Confirm Password*"),
                          suffixIcon: IconButton(onPressed: (){
                            show2=!show2;
                            setState(() {});
                          },icon: show2?Icon(Icons.remove_red_eye_sharp):Icon(Icons.remove_red_eye_outlined),)
                      ),
                      validator: (val){
                        if(val!=passwordController.text) {
                          return "Password does not match";
                        }
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: ElevatedButton(onPressed: ()async{
                        if(!formkey.currentState!.validate()){
                          _autovalidateMode=AutovalidateMode.always;
                          setState(() {});
                        }
                        else {
                          CustomDialog().show(context: context,text: "Signing Up...");
                          Address address=new Address(line1: line1Controller.text, line2: line2Controller.text, city: cityController.text, state: stateController.text, country: countryController.text, zip: int.parse(zipController.text));
                          Shift shift=new Shift(from: int.parse(fromController.text), to: int.parse(toController.text));
                          User user = new User(
                              name: nameController.text,
                              email: emailController.text,
                              address: address,
                              shift: shift,
                              phone: phoneController.text,
                              visa: int.parse(visaController.text),
                              password: passwordController.text,
                          );
                          try{
                            var res= await UserService().signUp(user);
                            var decoded=jsonDecode(res!.body);
                            if(decoded['_id']!=null){
                              CustomDialog().notShow(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You have been signed up as a sales alibi"),duration: Duration(seconds: 5),));
                              Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>LandingPage()));
                              return;
                            }
                            CustomDialog().notShow(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(decoded['error']),duration: Duration(seconds: 2),));
                            return;
                          }
                          catch(err){
                            if(err=="SocketException"){
                              CustomDialog().notShow(context);
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Unstable Connection"),duration: Duration(seconds: 2),));
                              return;
                            }
                            print(err);
                            CustomDialog().notShow(context);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong. Please try later"),duration: Duration(seconds: 2),));
                            return;
                          }
                        }
                      }, child: Text("Sign Up")),
                    ),
                  ),
                ],
              ),
            )
        ),
      ),
    );
  }
}
