import 'package:flutter/material.dart';

class ForgottenPasswordEmail extends StatefulWidget {
  String? email;
  ForgottenPasswordEmail({Key? key, this.email}) : super(key: key);

  @override
  State<ForgottenPasswordEmail> createState() => _ForgottenPasswordEmailState();
}

class _ForgottenPasswordEmailState extends State<ForgottenPasswordEmail> {

  TextEditingController emailController= new TextEditingController();
  var formkey=GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode= AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    if(widget.email!=null){
      emailController.text = widget.email as String;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_outlined),
            onPressed: (){
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
          title: Text("Forgotten Password",),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("Confirm your email below",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20
                ),
              ),
            ),
            Padding(
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
                            return "email can not be empty";
                          }
                          if(!val.contains("@")||!val.contains(".")){
                            return "Not a valid email format";
                          }
                        },
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
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("An email was sent to the provided email"),duration: Duration(seconds: 2),));
                              Navigator.pop(context);
                            }
                          }, child: Text("Recover")),
                        ),
                      ),
                    ],
                  ),
                )
            ),
          ],
        ),
      );
  }
}
