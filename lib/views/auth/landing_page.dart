import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fyp_ims/models/user.dart';
import 'package:fyp_ims/views/admin/adminHomePage.dart';
import 'package:fyp_ims/views/auth/forgottenPasswordEmail.dart';
import 'package:fyp_ims/interfacesDemo.dart';
import 'package:fyp_ims/views/auth/signUpPage.dart';
import 'package:fyp_ims/services/userService.dart';
import 'package:fyp_ims/components/dialog.dart';
import 'package:fyp_ims/views/manager/managerHomePage.dart';
import 'package:fyp_ims/views/salesman/salesmanHomePage.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  TextEditingController emailController= new TextEditingController();
  TextEditingController passwordController= new TextEditingController();
  var formkey=GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode= AutovalidateMode.disabled;
  bool show=true;
  bool showIncorrect=false;
  var profile;

  void checkLoggedIn()async{
    SharedPreferences prefs=await SharedPreferences.getInstance();
    if(prefs.getString('token')!=null){
      CustomDialog().show(context: context,text: "Logging in...");
      var res=await UserService().getProfile(prefs.getString('token'));
      var decoded=jsonDecode(res!.body);
      if(decoded['_id']!=null){
        User user= User.fromJson(decoded);
        if(user.guard==0){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => SalesmanHomePage(user: user,)));
        }
        else if(user.guard==1){
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (ctx) => ManagerHomePage(user: user,)));
        }
      }
      else{
        prefs.clear();
        CustomDialog().notShow(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please log in again!"),duration: Duration(seconds: 2),));
      }
    }
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text="user@gmail.com";
    passwordController.text="123456789";
    checkLoggedIn();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign In to sales"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: formkey,
          autovalidateMode: _autovalidateMode,
          child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text("Email"),
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
            TextFormField(
              controller: passwordController,
              obscureText: show,
              decoration: InputDecoration(
                label: Text("Password"),
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
              },
            ),

            Row(
              children: [
                Expanded(child: SizedBox()),
                TextButton(onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>ForgottenPasswordEmail()));
                },
                    child: Text("Forgotten Password")),
              ],
            ),
            showIncorrect?Text("Incorrect email or password",style: TextStyle(color: Colors.red),):SizedBox(),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ElevatedButton(onPressed: ()async{
                  SharedPreferences prefs=await SharedPreferences.getInstance();
                  if(!formkey.currentState!.validate()){
                    _autovalidateMode=AutovalidateMode.always;
                    setState(() {});
                  }
                  else{
                    CustomDialog().show(text: "Signing In...",context:context);
                    showIncorrect=false;
                    setState(() {});
                    var token;
                    try{
                      var res =await UserService().signIn(email: emailController.text,password: passwordController.text);
                      var decoded=jsonDecode(res!.body);
                      token=decoded['AccessToken'];
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
                    if(token!=null){
                      setState(() {});
                      print(token);
                      prefs.setString('token', token);
                      var res=await UserService().getProfile(token);
                      if(res.body!=null){
                        var decoded=jsonDecode(res!.body);
                        User user= User.fromJson(decoded);
                        CustomDialog().notShow(context);
                        if(user.guard==0){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (ctx) => SalesmanHomePage(user: user,)));
                        }
                        else if(user.guard==1){
                          Navigator.of(context).pushReplacement(MaterialPageRoute(
                              builder: (ctx) => ManagerHomePage(user: user,)));
                        }
                        else if(user.guard==2){
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("You are not supposed to be here"),duration: Duration(seconds: 2),));
                          return;
                        }
                      }
                      else{
                        CustomDialog().notShow(context);
                      }
                    }
                    else{
                      showIncorrect=true;
                      CustomDialog().notShow(context);
                      setState(() {});
                    }
                  }
                }, child: Text("Sign In")),
              ),
            ),
            Center(
              child: Text("OR")
            ),
            Center(
              child: ElevatedButton(onPressed: (){
                  //handle this
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>SignUpPage()));
              }, child: Text("Sign up")),
            ),
          ],
        ),
        )
      ),
    );
  }
}
