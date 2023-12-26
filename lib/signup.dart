import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchmovies/loginScreen.dart';

import 'MainProvider.dart';

class SignupScreen extends StatelessWidget {
  // String email,password;
   SignupScreen({super.key,});
   final _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    MainProvider provider = Provider.of<MainProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey ,

          child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text("Sign up here",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20),),

              SizedBox(height: 20),
              Consumer<MainProvider>(
                builder: (context,val,child) {
                  return Container(margin: EdgeInsets.symmetric(horizontal: 22),
                    child: TextFormField(key: ValueKey('name'),
                      controller:val.namectrl ,
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
                      hintText: "Enter Name",
                      hintStyle:TextStyle(color: Colors.white,fontSize: 15) ,
                      // labelText: "Enter name",
                      labelStyle: TextStyle(color: Colors.white,fontSize: 15)
                      ),
                      validator: (value){
                      if(value.toString().length<5){
                        return 'username is too small';
                      }
                      else{
                        return null;
                      }
                      },
                      style: const TextStyle(color: Colors.white),





                    ),
                  );
                }
              ),
              SizedBox(height: 10,),
              Container(margin: EdgeInsets.symmetric(horizontal: 22),
                child: Consumer<MainProvider>(
                  builder: (context,val,child) {
                    return TextFormField(key: ValueKey('email'),
                      controller:val.mailctrl ,

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
                      validator: (value){
                        if(!value.toString().contains("@")){
                          return 'Invalid email';
                        }
                        else{
                          return null;
                        }
                      },
                      style: const TextStyle(color: Colors.white),





                    );
                  }
                ),
              ),
              SizedBox(height: 10),
              Consumer<MainProvider>(
                  builder: (context,val,child) {
                    return Container(margin: EdgeInsets.symmetric(horizontal: 22),
                      child: TextFormField(key:ValueKey('password'),
                        obscureText: true,
                        controller:val.passctrl ,
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
                        validator: (value){
                          if(value.toString().length<5){
                            return 'password is too small';
                          }
                          else{
                            return null;
                          }
                        },
                        style: const TextStyle(color: Colors.white),





                      ),
                    );
                  }
              ),
              SizedBox(height: 10,),
              Consumer<MainProvider>(
                builder: (context,val,child) {
                  return ElevatedButton(onPressed: (){
                    final FormState? form = _formKey.currentState;
                    if (form!.validate()) {
                      val.signup(val.mailctrl.text, val.passctrl.text,context);
                    }
                    // Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen()));

                  }, child: Text("Register"));
                }
              ),
              TextButton(onPressed: (){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>LoginScreen()));
              }, child: Text("Already signed up? Login"))


            ],
          ),
        ),
      ),


    );
  }
}