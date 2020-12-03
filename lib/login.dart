import 'signup.dart';
import 'home.dart';
import 'package:hexcolor/hexcolor.dart';
import 'forgetpassword.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Login> {
  final _auth = FirebaseAuth.instance;
  GoogleSignIn _googleSignIn = new GoogleSignIn();
  User _user;

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 110.0, 0, 0),
                      child: Text(
                        "Hello",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(15.0, 175.0, 0, 0),
                      child: Text(
                        "There",
                        style: TextStyle(
                            fontSize: 80.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.fromLTRB(220.0, 175.0, 0, 0),
                      child: Text(
                        ".",
                        style: TextStyle(
                            color: HexColor("#2B55F8"),
                            fontSize: 80.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 80.0, left: 20.0, right: 20.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter your email';
                        return null;
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.green))),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter your password';
                        return null;
                      },
                    ),
                    SizedBox(height: 5.0),
                    Container(
                      alignment: Alignment(1.0, 0.0),
                      padding: EdgeInsets.only(top: 15, left: 20),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  new ForgetPassword()));
                        },
                        child: Text(
                          "Forget Password?",
                          style: TextStyle(
                            color: HexColor("#2B55F8"),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 40.0),
                    Container(
                      height: 40.0,
                      child: GestureDetector(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          shadowColor: HexColor("#718DFA"),
                          color: HexColor("#2B55F8"),
                          elevation: 3.0,
                          child: MaterialButton(
                            child: Center(
                              child: Text(
                                "LOGIN",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Montserrat',
                                ),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                _signInWithEmailAndPassword();
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
                      child: InkWell(
                        onTap: (){
                           handleSignIn();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor("#2B55F8"),
                              style: BorderStyle.solid,
                              width: 1.4,
                            ),
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Image(
                                  image: AssetImage("images/slider/google.png"),
                                ),
                              ),
                              SizedBox(width: 10.0),
                              Center(
                                child: Text(
                                  "Login With Google",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Montserrat',
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        // onPressed: () {
                        //   handleSignIn();
                        // },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "New to Tripply?",
                    style: TextStyle(
                      fontFamily: 'Montserrat',
                    ),
                  ),
                  SizedBox(width: 5.0),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => new Signup()));
                    },
                    child: Text(
                      "Register",
                      style: TextStyle(
                        color: HexColor("#2B55F8"),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Montserrat',
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ));
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User user = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return MyHomePage(
          user: user,
        );
      }));
    } catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),
      ));
    }
  }

  bool isSignIn = false;

  Future<void> handleSignIn() async {
    GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = (await _auth.signInWithCredential(credential));

    _user = result.user;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => MyHomePage(user: _user)));

    setState(() {
      isSignIn = true;
    });
  }

  Future<void> gooleSignout() async {
    await _auth.signOut().then((onValue) {
      _googleSignIn.signOut();
      setState(() {
        isSignIn = true;
      });
    });
  }
}
