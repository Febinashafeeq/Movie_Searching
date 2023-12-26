import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchmovies/signup.dart';

import 'MainProvider.dart';
import 'homeScreen.dart';

class LoginScreen extends StatelessWidget {
  // String email,password;
 LoginScreen({super.key});
  final formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore db = FirebaseFirestore.instance;

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    MainProvider provider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: formKey ,

          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text("Login here",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),


              SizedBox(height: 10,),
              Container(margin: EdgeInsets.symmetric(horizontal: 22),
                child: Consumer<MainProvider>(
                    builder: (context,val,child) {
                      return TextFormField(
                        controller:val.logctrl ,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),
                            hintText: "Enter your mail id",
                            hintStyle:TextStyle(color: Colors.white,fontSize: 15) ,
                            // labelText: "Enter name",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 15)
                        ),
                        style: const TextStyle(color: Colors.white),

                      );
                    }
                ),
              ),
              SizedBox(height: 10),
              Consumer<MainProvider>(
                  builder: (context,val,child) {
                    return Container(margin: EdgeInsets.symmetric(horizontal: 22),
                      child: TextFormField(obscureText: true,
                        controller:val.pctrl ,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),errorBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(59)),
                            borderSide: BorderSide(color: Colors.white60,width: 0.4)
                        ),
                            hintText: "Enter password",
                            hintStyle:TextStyle(color: Colors.white,fontSize: 15) ,
                            // labelText: "Enter name",
                            labelStyle: TextStyle(color: Colors.white,fontSize: 15)
                        ),
                        style: const TextStyle(color: Colors.white),





                      ),
                    );
                  }
              ),
              SizedBox(height: 10,),
              Consumer<MainProvider>(
                builder: (context,val,child) {
                  return Container(width: double.maxFinite,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(onPressed: (){
                      // if(val.logctrl.text.isNotEmpty && val.pctrl.text.length>6){
                        val.logInUser(email: val.logctrl.text, password: val.pctrl.text);
                      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomeScreen( currentPageCount: 1,movieName: "",)));

                      // }


                    }, child: Text("Login   ")),
                  );
                }
              ),

              TextButton(onPressed: (){
                // Navigator.of(context).push(MaterialPageRoute(builder: (context)=>SignupScreen()));
              }, child: Text("Don't have an Account? Signup"))


            ],
          ),
        ),
      ),


    );
  }
}
