import 'package:flutter/material.dart';
import 'package:mymoney_app/src/home.dart';
import 'client/user_client.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _showPassword = false;
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<User> futureUser;
  User _user;

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
                            suffixIcon: Icon(Icons.person),
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
                            setState(() {
                              futureUser = fetchUser(
                                _usernameController.text,
                                _passwordController.text,
                              );
                            });
                            futureUser.then((user) {
                              print(user.name);
                            });
                            Navigator.pushNamed(context, '/');
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
}

class LoginController {
  String _username;
  String _password;

  void _submit() {}
}
