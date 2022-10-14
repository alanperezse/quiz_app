import 'package:flutter/cupertino.dart';
import 'package:quiz_app/models/fill_in_question.dart';
import 'package:quiz_app/models/multiple_choice_question.dart';
import 'package:quiz_app/models/quiz.dart';

class QuestionScreen extends StatefulWidget {
  final int index;
  final Quiz quiz;
  const QuestionScreen({Key? key, required this.index, required this.quiz}) : super(key: key);
  
  @override
  State<QuestionScreen> createState() => _QuestionScreen();
}

class _QuestionScreen extends State<QuestionScreen> {
  int? index;

  @override
  void initState() {
    super.initState();
    index = widget.index;
  }

  void onNext() {
    setState(() {
      index = index! + 1;
    });
  }

  void onPrevious() {
    setState(() {
      index = index! - 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Question ${index! + 1}')
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
                        Text(widget.quiz.questions[index!].stem),
                        const SizedBox(
                          height: 20,
                        ),
                        widget.quiz.questions[index!].runtimeType == FillInQuestion ? 
                          FillInAnswer(question: widget.quiz.questions[index!] as FillInQuestion) :
                          MultipleChoiceAnswer(question: widget.quiz.questions[index!] as MultipleChoiceQuestion)
                      ],
                    )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: index! >= widget.quiz.length - 1 ? null : onNext,
                      child: const Text('Next'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      onPressed: index! <= 0 ? null : onPrevious,
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

class FillInAnswer extends StatefulWidget {
  final FillInQuestion question;

  const FillInAnswer({Key? key, required this.question}) : super(key: key);

  @override
  State<FillInAnswer> createState() => _FillInAnswer();
}

class _FillInAnswer extends State<FillInAnswer> {
  @override
  Widget build(BuildContext context) {
    return const Text('Fill in');
  }
}

class MultipleChoiceAnswer extends StatefulWidget {
  final MultipleChoiceQuestion question;

  const MultipleChoiceAnswer({Key? key, required this.question}) : super(key: key);
 
  @override
  State<MultipleChoiceAnswer> createState() => _MultipleChoiceAnswer();
}

class _MultipleChoiceAnswer extends State<MultipleChoiceAnswer> {
  @override
  Widget build(BuildContext context) {
    return const Text('Multiple choice');
  }
}