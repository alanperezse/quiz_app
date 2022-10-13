import 'package:flutter/cupertino.dart';
import 'package:quiz_app/models/quiz.dart';

class QuestionScreen extends StatefulWidget {
  var index = 0;
  final Quiz quiz;
  QuestionScreen({Key? key, required this.index, required this.quiz}) : super(key: key);
  
  @override
  State<QuestionScreen> createState() => _QuestionScreen();
}

class _QuestionScreen extends State<QuestionScreen> {
  void onNext() {
    setState(() {
      widget.index += 1;
    });
  }

  void onPrevious() {
    setState(() {
      widget.index -= 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Question ${widget.index + 1}')
          ),
          SliverFillRemaining(
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Text(widget.quiz.questions.toList()[widget.index].stem),
                      ],
                    )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: widget.index >= widget.quiz.length - 1 ? null : onNext,
                      child: const Text('Next'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      onPressed: widget.index <= 0 ? null : onPrevious,
                      child: const Text('Previous'),
                    ),
                  ),
                ],
              )
            )
          )
        ],
      )
    );
  } 
}