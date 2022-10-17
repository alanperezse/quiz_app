import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
  TextEditingController? _textController;

  @override
  void initState() {
    super.initState();
    initTextController();
  }

  @override
  void dispose() {
    disposeTextController();
    super.dispose();
  }

  void initTextController() {
    _textController = TextEditingController(
      text: widget.question.userAnswer
    );

    _textController!.addListener(() {
      widget.question.userAnswer = _textController!.text;
    });
  }

  void disposeTextController() {
    _textController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    disposeTextController();
    initTextController();
    return Row(
      children: [
        const Text(
          'Answer: ',
          style: TextStyle(
            color: Colors.pink
          ),
        ),
        Expanded(
          child: CupertinoTextField(
            controller: _textController,
            placeholder: 'Type your answer here',
            style: const TextStyle(
              color: Colors.grey
            ),
          )
        )
      ],
    );
  }
}

class MultipleChoiceAnswer extends StatefulWidget {
  final MultipleChoiceQuestion question;

  const MultipleChoiceAnswer({Key? key, required this.question}) : super(key: key);
 
  @override
  State<MultipleChoiceAnswer> createState() => _MultipleChoiceAnswer();
}

class _MultipleChoiceAnswer extends State<MultipleChoiceAnswer> {
  void onRadioChanged(int i) {
    setState(() {
      widget.question.userAnswer = i;
    });
  }

  List<CupertinoButton> radioOptions() {
    List<CupertinoButton> rtn = [];

    for (var i = 0; i < widget.question.choices.length; i++) {
      rtn.add(
        CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                widget.question.userAnswer == i + 1 ?
                  CupertinoIcons.check_mark_circled :
                  CupertinoIcons.circle
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget.question.choices[i],
                  style: const TextStyle(color: Colors.grey),
                ),
              )
            ],
          ),
          onPressed: () => onRadioChanged(i + 1)
        )
      );
    }

    return rtn;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: radioOptions()
    );
  }
}