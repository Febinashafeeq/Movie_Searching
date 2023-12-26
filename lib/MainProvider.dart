import 'dart:collection';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Movie{
  String title;
  String imageUrl;
  Movie( this.title, this.imageUrl);
}
class MainProvider extends ChangeNotifier{
  final FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController namectrl = TextEditingController();
  TextEditingController passctrl = TextEditingController();
  TextEditingController mailctrl = TextEditingController();
  TextEditingController logctrl = TextEditingController();
  TextEditingController pctrl = TextEditingController();
  void AddUsers(){
    String userid =DateTime.now().millisecondsSinceEpoch.toString();
    Map <String ,dynamic> usdermap = HashMap();
    usdermap["Name"]=namectrl.text;
    usdermap["Mail_Id"]=mailctrl.text;
    usdermap["Password"]=passctrl.text;
    db.collection("USERS").doc(userid).set(usdermap);
    notifyListeners();
  }

 signin(String email, String password) async {
   try {
     final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(

         email: email,
         password: password
     );
   } on FirebaseAuthException catch (e) {
     if (e.code == 'user-not-found') {
       print('No user found for that email.');
     } else if (e.code == 'wrong-password') {
       print('Wrong password provided for that user.');
     }
   }
 }


  signup(String email,String password, BuildContext ctxt ) async {
    try {
      print("Susscc");
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,

      );
      print("Succ");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(ctxt).showSnackBar(
          const SnackBar(
              content: Text(
                  "existssss!!!!  "),backgroundColor: Colors.deepOrange,),
        );
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e.toString()+"dffghh");
    }
  }
  Future<String> logInUser({
    required String email,
    required String password,
  }) async {
    String result = 'Some error occurred';
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        await  FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email, password: password);
        result = 'success';
      }
    } catch (err) {
      result = err.toString();
    }
    return result;
  }





List movieList=[];
String query ='kids';
String currentPage="1";
String apiUrl ='https://api.themoviedb.org/3/search/movie';
String apiKey ="b944d6eba2d3f434fdb9d98457345ae8";

callApi(String movieName, String currentPageCount) async {
  query = movieName;
  // currentPage = currentPageCount;

  print(currentPage.toString() + "ksdbhj");

  // final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie'));
  // final response = await http.get(Uri.parse('$apiUrl?api_key=$apiKey&query=$query&page=$currentPage'));
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/search/movie?api_key=b944d6eba2d3f434fdb9d98457345ae8&query=kids&page=1'));

  if (response.statusCode == 200) {
    print(response.body);
    final Map<String, dynamic> data = json.decode(response.body);

    movieList.clear();

    for (var result in data['results']) {
      String title = result['title'];
      String imageUrl = ' https://image.tmdb.org/t/p/w780 ${result['poster_path']}';

      // String imageUrl = 'https://image.tmdb.org/t/p/w780 ${result['poster_path']}';
      // print(imageUrl + "sdokfkjfs");
      movieList.add(Movie( title, imageUrl));

print(movieList.first.imageUrl);

      notifyListeners();

      print(movieList.length.toString() + "list lenghth");
    }
  } else {
    print("faaaaaaaaails");
  }
  notifyListeners();
}

  }
