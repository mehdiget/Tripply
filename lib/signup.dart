import 'home.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => new _SignupState();
}

class _SignupState extends State<Signup> {
  final _auth = FirebaseAuth.instance;
  bool _isSuccess;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _displayName = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  String _userEmail;
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 175.0, 0, 0),
                      child: Text(
                        "Signup",
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(259.0, 175.0, 0, 0),
                      child: Text(
                        ".",
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 40.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _displayName,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          labelText: 'NAME',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      // onChanged: (value) {
                      //   setState(() {
                      //     _name = value.trim();
                      //   });
                      // },
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: const InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      obscureText: true,
                    ),
                    SizedBox(height: 50.0),
                    Container(
                      height: 40.0,
                      child: GestureDetector(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          shadowColor: Colors.greenAccent,
                          color: Colors.green,
                          elevation: 3.0,
                          child: MaterialButton(
                            child: Center(
                              child: Text(
                                "SIGN UP",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                            onPressed: () async {
                              print("We Begin ......");
                              print("Email : " + _emailController.text);
                              print("Password : " + _passwordController.text);
                              if (_formKey.currentState.validate()) {
                                _registerAccount();
                              }
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Container(
                      height: 40,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 1.0,
                          ),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      new Login()));
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.arrow_back,
                                  ),
                                ),
                                SizedBox(width: 5.0),
                                Center(
                                  child: Text(
                                    "BACK",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ),
                                  ),
                                )
                              ],
                            )),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void _registerAccount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    ))
        .user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displayName.text);
      final user1 = _auth.currentUser;
      print("UID is : "+user.uid);
      await FirebaseFirestore.instance.collection('users').doc(user1.uid).set({
        'name':  _displayName.text,
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => MyHomePage(
                user: user1,
              )));
    } else {
      _isSuccess = false;
    }
  }
}
