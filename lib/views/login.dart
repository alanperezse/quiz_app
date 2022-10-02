import 'package:flutter/cupertino.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

class _LoginScreen extends State<LoginScreen> {
  final LoginData _loginData = LoginData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String? _userNameValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? _pinValidator(String? val) {
    if (val == null || val.length != 4) {
      return 'PIN must be exactly 4 digits';
    }
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

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
              CupertinoFormSection.insetGrouped(
                margin: const EdgeInsets.all(30.0),
                children: [
                  CupertinoTextFormFieldRow(
                    textAlign: TextAlign.end,
                    prefix: const Text('Email'),
                    textInputAction: TextInputAction.next,
                    placeholder: 'username@email.com',
                    validator: _userNameValidator,
                    onSaved: (val) {
                      _loginData.username = val!;
                    },
                  ),
                  CupertinoTextFormFieldRow(
                    textAlign: TextAlign.end,
                    obscureText: true,
                    prefix: const Text('PIN'),
                    textInputAction: TextInputAction.done,
                    placeholder: '****',
                    validator: _pinValidator,
                    onSaved: (val) {
                      _loginData.password = val!;
                    },
                  ),
                ]
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: CupertinoButton.filled (
                        onPressed: _submit,
                        child: const Text('Submit'),
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