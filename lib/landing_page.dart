import 'package:flutter/material.dart';
import 'package:fyp_ims/forgottenPasswordEmail.dart';
import 'package:fyp_ims/interfacesDemo.dart';
import 'package:fyp_ims/signUpPage.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController.text="demo@test.com";
    passwordController.text="12345678";
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
                if(val==null) {
                  return "Email can not be empty";
                }
                if(!val.contains("@")||!val.contains(".")){
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
                if(val==null) {
                  return "Password can not be empty";
                }
                if(val.length<8){
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
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ElevatedButton(onPressed: (){
                  if(!formkey.currentState!.validate()){
                    _autovalidateMode=AutovalidateMode.always;
                    setState(() {});
                  }
                  else{
                    //handle this
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>InterfacesDemo()));
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
