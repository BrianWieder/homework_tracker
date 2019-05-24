import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() {
    return _LoginScreenState();
  }
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> _loginFormKey = GlobalKey();

  String email = '';
  String password = '';
  String name = '';

  bool signedUp = false;

  _LoginScreenState() {
    _auth.onAuthStateChanged.listen(this.onAuthStateChanged);
  }

  void onAuthStateChanged(FirebaseUser user) {
    if (user != null) {
      if (signedUp) {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Please enter your name"),
                content: TextField(
                  decoration: InputDecoration(
                      hintText: "Brian Wieder", labelText: "Name"),
                  onChanged: (name) {
                    setState(() {
                      this.name = name;
                    });
                  },
                ),
                actions: <Widget>[
                  FlatButton(
                    child: Text("Done"),
                    onPressed: () {
                      UserUpdateInfo userInfo = UserUpdateInfo();
                      userInfo.displayName = name;
                      user.updateProfile(userInfo);
                      Navigator.of(context).pushReplacementNamed("/main");
                    },
                  )
                ],
              );
            });
      } else {
        Navigator.of(context).pushReplacementNamed("/main");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homework Tracker"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Form(
          key: _loginFormKey,
          child: Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: Icon(Icons.email),
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'You@email.com',
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (String value) {
                        return value.contains("@") && value.contains(".")
                            ? null
                            : "Please enter a valid email";
                      },
                      onSaved: (String value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(right: 15),
                    child: Icon(Icons.lock),
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Password',
                      ),
                      obscureText: true,
                      validator: (String value) {
                        return value.length >= 6
                            ? null
                            : "Your password must be at least 6 characters";
                      },
                      onSaved: (String value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Sign In"),
                      onPressed: () {
                        if (_loginFormKey.currentState.validate()) {
                          _loginFormKey.currentState.save();
                          try {
                            _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                          } catch (e) {
                            print(e.toString());
                          }
                        }
                      },
                    ),
                    RaisedButton(
                      child: Text("Register"),
                      onPressed: () {
                        if (_loginFormKey.currentState.validate()) {
                          setState(() {
                            signedUp = true;
                          });
                          _loginFormKey.currentState.save();
                          _auth
                              .createUserWithEmailAndPassword(
                                  email: email, password: password)
                              .then((user) {});
                        }
                      },
                      color: Theme.of(context).accentColor,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
