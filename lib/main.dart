import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'Screens/Home Page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;


const blue = Color(0xFF1A529F);
const yellow = Color(0xFFE7AA4B);

//create Account
Future<Account> createAccount(String username) async {
  final response = await http.post(
    Uri.parse('https://cheffron.elian.tk/user'),
    headers: <String, String>{
      "jwt":"eyJhbGciOiJSUzI1NiJ9.eyJzdWIiOiI5OWQxZTMwYy00ZDhiLTRiYmItOTY0NS05"
          "MjdlYjI3NzgwYzIiLCJ1c2VybmFtZSI6ImVsaWFuIiwiaWF0IjoxNjQ3NzEwNjkzfQ.Z"
          "P_dfWl7ZPCP7r72KmgGffb11MxWlaLxc3Ld8cVAnxqEHmtf1pHbEsloL7HmJ-yGlQVE"
          "DOKa6Ig4W8f2XSHG5AijeRMVO8w2X08xyIrVhbdAvSaXyCJqfjaudllWdvoMMVFNXxT"
          "rFJU121YqrgRsbMKHfl7XfQFu60aYlOq7rsyDQUA76hE6H_PsNAr_Fy-DG4ePz95plt"
          "hWujT3VVkb2RNuZCsr6RE8H3jxA9xMkqxxmvYDUqmwPpnTwLCRIy8sW9-e-sM9SUnsY"
          "iUrKB_9PZroduHUH4H_EBaK_qyg5OTEqZu6fqL7pSXMaag1gR82YcUM0qksu_5AEpSL"
          "rrBQ9w",
    },
    body: jsonEncode(<String, String>{
      "username": "elian", "name": "Elian", "email": "elian1203@gmail.com",
      "password": "cGFzc3dvcmQ="
    }),
  );

  if (response.statusCode == 201) {
    // If the server did return a 201 CREATED response,
    // then parse the JSON.
    return Account.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create account.');
  }
}

class Account {
  final int id;
  final String username;
  final String password;

  const Account({required this.id, required this.username, required this.password});

  factory Account.fromJson(Map<String, dynamic> json) {
    return Account(
      id: json['id'],
      username: json['username'],
      password: json['password'],
    );
  }
}

void main() {
  //final SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  //Future<Account>? _futureAccount;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cheffron',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor: blue,
        body: const LoginScreen(),
        bottomNavigationBar: BottomAppBar(
            color: Colors.transparent,
            elevation: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                "UNF PROJECT",
                style: TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            )),
      ),
    );
  }
}


/*FutureBuilder<Account> buildFutureBuilder() {
  return FutureBuilder<Account>(
    future: _futureAccount,
    builder: (context, snapshot) {
      if (snapshot.hasData) {
        return Text(snapshot.data!.username);
      } else if (snapshot.hasError) {
        return Text('${snapshot.error}');
      }

      return const CircularProgressIndicator();
    },
  );
}
}*/

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _isObscure = true;
  bool _isVisible = false;

  fetchCredentials() {
    var username = "username";
    var password = "password123";
    return [username, password];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 80,
              width: 200,
            ),

            // Login text Widget
            Center(
              child: Container(
                height: 200,
                width: 400,
                alignment: Alignment.center,
                child: const Text(
                  "Logo will go here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
              width: 10,
            ),

            // Wrong Password text
            Visibility(
              visible: _isVisible,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              child: Container(
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.all(10),
                child: const Text(
                  "Username or password is incorrect",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 10,
                  ),
                ),
              ),
            ),

            // Username input
            Container(
              height: 60,
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: usernameController, // Controller for Username
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                ],
              ),
            ),

            //divider between username and password
            const SizedBox(
              height: 30,
            ),

            //password input
            Container(
                height: 60,
                width: 530,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },

                      controller: passwordController, // Controller for Password
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          contentPadding: const EdgeInsets.all(20),
                          // Adding the visibility icon to toggle visibility of the password field
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )),
                      obscureText: _isObscure,
                    ),
                  ],
                )
            ),

            const SizedBox(
              height: 130,
            ),

            // Login Button
            Container(
              width: 570,
              height: 70,
              padding: const EdgeInsets.only(top: 20),
              child: RaisedButton(
                  color: yellow,
                  child: const Text(
                      "LOG IN", style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    if (kDebugMode) {
                      print(
                          "Username: ${usernameController
                              .text}, password: ${passwordController.text}");
                      if (usernameController.text == fetchCredentials()[0] &&
                          passwordController.text == fetchCredentials()[1]) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                              (Route<dynamic> route) => false,
                        );
                      } else {
                        setState(() {
                          _isVisible = true;
                        });
                      }
                    }
                  }),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const RaisedButton(
                onPressed: null,
                child: Text("Don't have an account? Sign up!",
                  style: TextStyle(color: yellow),),
                disabledColor: blue, //only needed because the button does nothing for now
              ),
            )
          ],
        ));
  }
}



// Created SighUpPage

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _isObscure = true;
  bool _isVisible = false;

  fetchCredentials() {
    var firstName = "";
    var lastName = "";
    var email = "";
    var username = "";
    var password = "";
    return [firstName, lastName,email, username, password];
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        reverse: true,
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(
              height: 80,
              width: 200,
            ),

            // Signup text Widget
            Center(
              child: Container(
                height: 200,
                width: 400,
                alignment: Alignment.center,
                child: const Text(
                  "Logo will go here",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  ),
                  // textAlign: TextAlign.center,
                ),
              ),
            ),

            const SizedBox(
              height: 10,
              width: 10,
            ),



            // FirstName input
            Container(
              height: 60,
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: firstnameController, // Controller for firstname
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "First Name",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                ],
              ),
            ),

            //divider between Firstname and Lastname
            const SizedBox(
              height: 30,
            ),


// Lastname input
            Container(
              height: 60,
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: lastnameController, // Controller for lastname
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Last Name",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                ],
              ),
            ),

            //divider between Lastname and email
            const SizedBox(
              height: 30,
            ),


// Email input
            Container(
              height: 60,
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: emailController, // Controller for Email
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Email",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                ],
              ),
            ),

            //divider between email and username
            const SizedBox(
              height: 30,
            ),


            // Username input
            Container(
              height: 60,
              width: 530,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.white),
              child: Column(
                children: <Widget>[
                  TextFormField(
                    onTap: () {
                      setState(() {
                        _isVisible = false;
                      });
                    },
                    controller: usernameController, // Controller for Username
                    decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Username",
                        contentPadding: EdgeInsets.all(20)),
                    onEditingComplete: () => FocusScope.of(context).nextFocus(),
                  ),
                ],
              ),
            ),

            //divider between username and password
            const SizedBox(
              height: 30,
            ),

            //password input
            Container(
                height: 60,
                width: 530,
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    color: Colors.white),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      onTap: () {
                        setState(() {
                          _isVisible = false;
                        });
                      },

                      controller: passwordController, // Controller for Password
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: " Create Password",
                          contentPadding: const EdgeInsets.all(20),
                          // Adding the visibility icon to toggle visibility of the password field
                          suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility_off
                                : Icons.visibility),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          )),
                      obscureText: _isObscure,
                    ),
                  ],
                )
            ),

            const SizedBox(
              height: 130,
            ),

            // Create Account button
            Container(
              width: 570,
              height: 70,
              padding: const EdgeInsets.only(top: 20),
              child: RaisedButton(
                  color: yellow,
                  child: const Text(
                      "Create Account", style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  onPressed: () {
                    if (kDebugMode) {
                      print("First Name:${firstnameController.text},Last Name: ${lastnameController.text}, Email: ${emailController.text}Username: ${usernameController
                              .text}, password: ${passwordController.text}");
                      if (firstnameController.text== fetchCredentials()[0] && lastnameController == fetchCredentials()[0]&& emailController == fetchCredentials()[0] &&
                          usernameController.text == fetchCredentials()[0] &&
                          passwordController.text == fetchCredentials()[1]) {
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => HomePage()),
                              (Route<dynamic> route) => false,
                        );
                      } else {
                        setState(() {
                          _isVisible = true;
                        });
                      }
                    }
                  }),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(10),
              child: const RaisedButton(
                onPressed: null,
                child: Text("Already have an account? Log In!",
                  style: TextStyle(color: yellow),),
                disabledColor: blue, //only needed because the button does nothing for now
              ),
            )
          ],
        ));
  }
}


