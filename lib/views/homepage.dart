import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/login_data.dart';

class MyHomePage extends StatelessWidget {
  final LoginData loginData;

  const MyHomePage({super.key, required this.loginData});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Home'),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  child: QuizInfoWidget(loginData: loginData),
                )
              ]
            )
          )
        ],
      )
    );
  }
}

class QuizInfoWidget extends StatefulWidget {
  final LoginData loginData;

  const QuizInfoWidget({Key? key, required this.loginData}) : super(key: key);

  @override
  State<QuizInfoWidget> createState() => _QuizInfoWidget();
}

class _QuizInfoWidget extends State<QuizInfoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[900]
      ),
      child: Column(
        children: [
          Text(
            'Questions found',
            style: TextStyle(fontFamily: 'Alkalami', fontSize: 20, color: Colors.grey),
            textAlign: TextAlign.start,
          ),
          Container(
            child: Text(
              '139',
              style: TextStyle(fontFamily: 'Alkalami', fontSize: 60)
            ),
          ),
          Container(
            width: double.infinity,
            child: CupertinoButton.filled(
              child: Text('Take quiz'), onPressed: () {}
            )
          )
        ],
      )
    );
  }
}