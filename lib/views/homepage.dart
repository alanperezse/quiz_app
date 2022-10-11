import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/login_data.dart';
import 'package:quiz_app/models/question_pool.dart';

class MyHomePage extends StatelessWidget {
  final LoginData loginData;
  final QuestionPool questionPool = const QuestionPool();

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
                  child: QuizInfoWidget(loginData: loginData, questionPool: questionPool),
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
  final QuestionPool questionPool;

  const QuizInfoWidget({Key? key, required this.loginData, required this.questionPool}) : super(key: key);

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
              '${widget.questionPool.length}',
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