import 'package:flutter/cupertino.dart';
import 'package:quiz_app/views/home_screen.dart';
import '../models/login_response.dart';
import '../models/login_data.dart';
import 'package:quiz_app/utilities/api_util.dart';

/// Widget for the Log in screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreen();
}

/// State of the LoginScreen widget
class _LoginScreen extends State<LoginScreen> {
  final _loginData = LoginData();
  final _formKey = GlobalKey<FormState>();
  final _api = APIUtil();
  var _isButtonDisabled = false;

  // Prompts alert box
  void _showAlertDialog(BuildContext context, String title, String body) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(body),
        actions: <CupertinoDialogAction>[
          CupertinoDialogAction(
            /// This parameter indicates this action is the default,
            /// and turns the action's text to bold text.
            isDefaultAction: true,
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          )
        ],
      ),
    );
  }

  /// Validates the username
  String? _userNameValidator(String? val) {
    if (val == null || val.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  /// Validates the pin. The pin must be exactly 4 characters long
  String? _pinValidator(String? val) {
    if (val == null || val.length != 4) {
      return 'PIN must be exactly 4 digits';
    }
    return null;
  }

  /// Attempts to submit the form and authenticate the user
  void _submit() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() => _isButtonDisabled = true);
      _api.validateUser(_loginData)
        .then((LoginResponse response) {
          if(response.response) {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (BuildContext context) => HomeScreen(loginData: _loginData,))
            );
          } else {
            _showAlertDialog(context, 'Error', response.reason!);
            setState(() => _isButtonDisabled = false);
          }
        })
        .catchError((error) {
          print(error);
          setState(() => _isButtonDisabled = false);
        });
    }
  }

  /// Defines the view
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
                    prefix: const Text('Username'),
                    textInputAction: TextInputAction.next,
                    placeholder: 'username',
                    validator: _userNameValidator,
                    onSaved: (val) {
                      _loginData.username = val!;
                    },
                  ),
                  CupertinoTextFormFieldRow(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.end,
                    obscureText: true,
                    prefix: const Text('PIN'),
                    textInputAction: TextInputAction.done,
                    placeholder: '****',
                    validator: _pinValidator,
                    onSaved: (val) {
                      _loginData.pin = val!;
                    },
                  ),
                ]
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                child: CupertinoButton.filled (
                  onPressed: _isButtonDisabled ? () {} : _submit,
                  child: _isButtonDisabled ?
                    const CupertinoActivityIndicator() :
                    const Text('Submit'),
                )
              )
            ],
          )
        )
      )
    );
  }
}
