import 'signup.dart';
import 'dashboard.dart';
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
    Size size = MediaQuery.of(context).size;
    return Form(
        key: _formKey,
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomPadding: false,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.4,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: AssetImage("images/assets/colon.png"))),
                      // padding: EdgeInsets.only(top: 380, right: 380,),
                    ),
                    Container(
                        padding: EdgeInsets.only(
                          top: size.height * 0.2,
                          left: size.width * 0.375,
                        ),
                        child: Text(
                          "Tripply",
                          style: TextStyle(
                              fontSize: 41,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Assistant"),
                        )),
                    Container(
                        padding: EdgeInsets.only(
                          left: size.width * 0.379,
                          top: size.height * 0.267,
                        ),
                        child: Text(
                          "Discover Moroccoland",
                          style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Assistant"),
                        )),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(
                    top: size.height * 0.03,
                    left: size.width * 0.05,
                    right: size.width * 0.05),
                child: Column(
                  children: [
                    TextFormField(
                      controller: _emailController,
                      decoration: InputDecoration(
                          labelText: 'EMAIL',
                          labelStyle: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#FC3E3F")))),
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter your email';
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.025),
                    TextFormField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                          labelText: 'PASSWORD',
                          labelStyle: TextStyle(
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.bold,
                              color: Colors.grey),
                          focusedBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: HexColor("#FC3E3F")))),
                      obscureText: true,
                      validator: (value) {
                        if (value.isEmpty) return 'Please enter your password';
                        return null;
                      },
                    ),
                    SizedBox(height: size.height * 0.01),
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
                            color: HexColor("#FC3E3F"),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Montserrat',
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),
                    Container(
                      height: size.height * 0.06,
                      child: GestureDetector(
                        child: Material(
                          borderRadius: BorderRadius.circular(20),
                          shadowColor: HexColor("#718DFA"),
                          color: HexColor("#FC3E3F"),
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
                    SizedBox(height: size.height * 0.025),
                    Container(
                      height: size.height * 0.06,
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          handleSignIn();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: HexColor("#FC3E3F"),
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
                                  image: AssetImage("images/assets/google.png"),
                                ),
                              ),
                              SizedBox(width: size.height * 0.015),
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
              SizedBox(height: size.height * 0.015),
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
                        color: HexColor("#FC3E3F"),
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
        return Dashboard(
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

    AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken);

    UserCredential result = (await _auth.signInWithCredential(credential));

    _user = result.user;
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => Dashboard(user: _user)));

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
