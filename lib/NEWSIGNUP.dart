//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
//
// class UserModel{
//   final String email;
//   final String name;
//   final String uid;
//   final String username;
//   final List followers;
//   final List following;
//
//   UserModel(
//       {required this.email,
//         required this.name,
//         required this.username,
//         required this.uid,
//         required this.followers,
//         required this.following});
//
//   Map<String, dynamic> toJson() => {
//     "email": email,
//     "uid": uid,
//     "name": name,
//     "username": username,
//     "followers": followers,
//     "following": following,
//   };
//
//   static UserModel? fromSnap (DocumentSnapshot snap) {
//     var snapshot = snap.data() as Map<String, dynamic>;
//     return UserModel(
//       username: snapshot['username'],
//       uid: snapshot['uid'],
//       name: snapshot['name'],
//       following: snapshot['following'],
//       followers: snapshot['followers'],
//       email: snapshot['email'],
//     );
//   }
// }
//
//
// class AuthMethods {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//
//
//
//   Future<String> signUpUser({
//     required String? name,
//     required String? email,
//     required String? password,
//     required String? username,
//   }) async {
//     String result = 'Some error occurred';
//     try {
//       if (email!.isNotEmpty || name!.isNotEmpty || password!.isNotEmpty) {
//         UserCredential user = await _auth.createUserWithEmailAndPassword(
//             email: email, password: password!);
//         print(user.user!.uid);
//
//         UserModel userModel = UserModel(
//           email: email,
//           name: name!,
//           uid: user.user!.uid,
//           username: username!,
//           followers: [],
//           following: [],
//         );
//
//         await _firestore.collection('users').doc(user.user!.uid).set(
//           userModel.toJson(),
//         );
//         result = 'success';
//       }
//     } catch (err) {
//       result = err.toString();
//     }
//     return result;
//   }
//
//   Future<String> logInUser({
//     required String email,
//     required String password,
//   }) async {
//     String result = 'Some error occurred';
//     try {
//       if (email.isNotEmpty || password.isNotEmpty) {
//         await _auth.signInWithEmailAndPassword(
//             email: email, password: password);
//         result = 'success';
//       }
//     } catch (err) {
//       result = err.toString();
//     }
//     return result;
//   }
// }
//
//
// class SignupScreen extends StatefulWidget {
//   static final String id = 'signup_screen';
//
//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }
//
// class _SignupScreenState extends State<SignupScreen> {
//   final _formKey = GlobalKey<FormState>();
//   String? _name;
//   String? _email;
//   String? _password;
//   String? _userName;
//   bool _isLoading = false;
//
//   void _signUp() async {
//     if (_formKey.currentState!.validate()) {
//       _formKey.currentState!.save();
//       setState(() {
//         _isLoading = true;
//       });
//       // Logging in the user w/ Firebase
//       String result = await AuthMethods()
//           .signUpUser(name: _name, email: _email, password: _password, username: _userName);
//       if (result != 'success') {
//         print(result+"sdghfghcdfghscdf");
//       } else {
//         Navigator.pop(context);
//       }
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Text(
//                 'Instagram',
//                 style: TextStyle(
//                   fontFamily: 'Billabong',
//                   fontSize: 50.0,
//                 ),
//               ),
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 30.0,
//                         vertical: 10.0,
//                       ),
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Name'),
//                         validator: (input) => input!.trim().isEmpty
//                             ? 'Please enter a valid name'
//                             : null,
//                         onSaved: (input) => _name = input!,
//                       ),
//                     ),Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 30.0,
//                         vertical: 10.0,
//                       ),
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Username'),
//                         validator: (input) => input!.trim().isEmpty
//                             ? 'Please enter a valid username'
//                             : null,
//                         onSaved: (input) => _userName = input!,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 30.0,
//                         vertical: 10.0,
//                       ),
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Email'),
//                         validator: (input) => !input!.contains('@')
//                             ? 'Please enter a valid email'
//                             : null,
//                         onSaved: (input) => _email = input!,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 30.0,
//                         vertical: 10.0,
//                       ),
//                       child: TextFormField(
//                         decoration: InputDecoration(labelText: 'Password'),
//                         validator: (input) => input!.length < 6
//                             ? 'Must be at least 6 characters'
//                             : null,
//                         onSaved: (input) => _password = input!,
//                         obscureText: true,
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Padding(
//                       padding: EdgeInsets.only(
//                         left: 40,
//                         right: 40,
//                       ),
//                       child: Container(
//                         width: double.infinity,
//                         color: Colors.blue,
//                         child: _isLoading
//                             ? Center(
//                           child: CircularProgressIndicator(
//                             color: Colors.white,
//                           ),
//                         )
//                             : TextButton(
//                           onPressed: () => _signUp(),
//                           child: Text(
//                             'Sign Up',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18.0,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 20.0),
//                     Container(
//                       color: Colors.blue,
//                       padding: EdgeInsets.symmetric(horizontal: 50),
//                       child: TextButton(
//                         onPressed: () => Navigator.pop(context),
//                         child: Text(
//                           'Back to Login',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 18.0,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }