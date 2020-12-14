import 'Dashboard.dart';
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hexcolor/hexcolor.dart';

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
    Size size = MediaQuery.of(context).size;
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
                      // padding: EdgeInsets.only(left: 45, bottom: 0, top: 0,),
                      child: Image.asset(
                        'images/assets/khayma.png',
                        width: size.width * 0.8,
                      ),
                      padding: EdgeInsets.only(left: size.width * 0.1),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    left: size.width * 0.05, right: size.width * 0.05),
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
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.025),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                      validator: (String value) {
                        if (value.isEmpty) {
                          return 'Please enter your email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.025),
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
                    SizedBox(height: size.height * 0.08),
                    Container(
                      height: size.height * 0.06,
                      child: GestureDetector(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          shadowColor: Colors.pinkAccent,
                          color: HexColor("#FC3E3F"),
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
                    SizedBox(height:size.height * 0.025),
                    Container(
                      height: size.height * 0.06,
                      color: Colors.transparent,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: HexColor("#FC3E3F"),
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
      print("UID is : " + user.uid);
      await FirebaseFirestore.instance.collection('users').doc(user1.uid).set({
        'name': _displayName.text,
      });

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => Dashboard(
                user: user1,
              )));
    } else {
      _isSuccess = false;
    }
  }
}
