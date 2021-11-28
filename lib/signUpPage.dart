import 'package:flutter/material.dart';

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
  var formkey=GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode= AutovalidateMode.disabled;
  bool show=true;
  bool show2=true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController.text="abc";
    emailController.text="demo@test.com";
    passwordController.text="12345678";
    passwordController2.text="12345678";
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
                  controller: nameController,
                  decoration: InputDecoration(
                    label: Text("Name"),
                  ),
                  validator: (val){
                    if(val==null) {
                      return "Name can not be empty";
                    }
                  },
                ),
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
                    if(val!=passwordController2.text) {
                      return "Password does not match";
                    }
                  },
                ),
                TextFormField(
                  controller: passwordController2,
                  obscureText: show2,
                  decoration: InputDecoration(
                      label: Text("Confirm Password"),
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
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: ElevatedButton(onPressed: ()async{
                      if(!formkey.currentState!.validate()){
                        _autovalidateMode=AutovalidateMode.always;
                        setState(() {});
                      }
                      else {
                        //handle this
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Your request was sent to the manager"),duration: Duration(seconds: 2),));
                        await Future.delayed(Duration(milliseconds: 700));
                        Navigator.of(context).pop();
                      }
                    }, child: Text("Sign Up")),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}
