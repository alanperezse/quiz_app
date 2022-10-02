import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}


class _LoginScreen extends State<LoginScreen> {
  final LoginData _loginData = LoginData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Login'),
      ),
      child: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              CupertinoFormSection(
                margin: const EdgeInsets.all(30.0),
                children: [
                  CupertinoTextFormFieldRow(
                    prefix: const Text('Email'),
                    textInputAction: TextInputAction.next,
                    placeholder: 'alanperezeptx@gmail.com',
                    validator: (String? val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _loginData.username = val!;
                    },
                  ),
                  CupertinoTextFormFieldRow(
                    obscureText: true,
                    prefix: const Text('PIN'),
                    textInputAction: TextInputAction.next,
                    placeholder: 'alanperezeptx@gmail.com',
                    validator: (String? val) {
                      if (val == null || val.length != 4) {
                        return 'PIN must be exactly 4 digits';
                      }
                      return null;
                    },
                    onSaved: (val) {
                      _loginData.username = val!;
                    },
                  ),
                ]
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: CupertinoButton.filled (
                        child: const Text('Submit'),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                          }
                        }
                      )
              )
            ],
          )
        )
      )
    );
  }
}

class LoginData {
  String username = "";
  String password = "";
}