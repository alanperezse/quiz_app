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
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  QuizInfoWidget(),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 30),
                    child: CupertinoButton.filled(
                      onPressed: () {},
                      child: Text('Take quiz'),
                  )
                  )
                ]
              )
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
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[900]
      ),
      child: 
      IntrinsicHeight(child: 
            Row(
        children: <Widget>[
          Expanded(
              child: Text(
                '139\nQuestions',
                textAlign: TextAlign.center,
            ),
          ),
          VerticalDivider(
            width: 10,
            indent: 5,
            endIndent: 5,
            color: Colors.grey,
            thickness: 1,
          ),
          CupertinoButton(
            child: Column(
              children: const [
                Icon(
                  CupertinoIcons.arrow_clockwise
                ),
                Text('Update')
              ],
            ),
            onPressed: () {}
          )
        ]
      ),
      )
    );
  }
}