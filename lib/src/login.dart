import 'package:flutter/material.dart';
import 'package:mymoney_app/src/model/user_model.dart';
import 'package:mymoney_app/src/repository/authentication.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _showPassword = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<User> futureUser;
  Authentication _authentication = Authentication();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Container(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            suffixIcon: Icon(Icons.account_circle),
                            labelText: 'Username',
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 10.0,
                              horizontal: 20.0,
                            ),
                            suffixIcon: Icon(Icons.lock),
                            labelText: 'Password',
                          ),
                        ),
                        CheckboxListTile(
                          title: Text('Show password?'),
                          value: _showPassword,
                          onChanged: (checked) {
                            setState(() {
                              _showPassword = checked;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.leading,
                        ),
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(5.0),
                            ),
                          ),
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          child: Text('Login'),
                          onPressed: () {
                            authenticateUser();
                          },
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  authenticateUser() async {
    _authentication
        .fetchUser(_usernameController.text, _passwordController.text)
        .then((user) {
      Navigator.pushReplacementNamed(context, '/');
    }).catchError((err) {
      showDialog(
        context: context,
        builder: (context) {
          return new AlertDialog(
            title: new Text("Something went wrong :("),
            content: new Text("Error: " + err.toString()),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Close"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    });
  }
}
