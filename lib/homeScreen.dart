import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:searchmovies/MainProvider.dart';

class HomeScreen extends StatelessWidget {
  String movieName;
  int currentPageCount;

   HomeScreen({super.key,required this.movieName,required this.currentPageCount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 5,
          ),
          Consumer<MainProvider>(
            builder: (context,val,child) {
              return TextFormField(
                onTap: (){
                val.callApi(movieName, "");

              },
                decoration: InputDecoration(filled: true,
                    fillColor: Colors.white.withOpacity(.30),
                    suffixIcon: Icon(Icons.cancel),
                    prefixIcon: Icon(Icons.search),focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),),hintText: "Search Movie Name"),

              );

            }
          ),

        ],
      ),
    );
  }
}
