import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

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
                  child: QuizInfoWidget(),
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
  const QuizInfoWidget({Key? key}) : super(key: key);

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
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 20),
                child: Text(
                  '139',
                  style: TextStyle(fontFamily: 'Alkalami', fontSize: 60)
                ),
              ),
              Text(
                'Questions\nfound',
                style: TextStyle(fontFamily: 'Alkalami', fontSize: 20, color: Colors.grey),
                textAlign: TextAlign.start,
              )
            ],
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