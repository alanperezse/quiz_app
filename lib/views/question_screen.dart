import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/fill_in_question.dart';
import 'package:quiz_app/models/multiple_choice_question.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/utilities/api_util.dart';

/// Widget that represents the view to a question
class QuestionScreen extends StatefulWidget {
  final int _index;
  final Quiz _quiz;
  final APIUtil _api = APIUtil();

  /// Initializes the widget
  QuestionScreen({Key? key, required index, required quiz}) :
    _index = index,
    _quiz = quiz,
    super(key: key)
    ;
  
  @override
  State<QuestionScreen> createState() => _QuestionScreen();
}

/// State of QuestionScreen widget
class _QuestionScreen extends State<QuestionScreen> {
  int? _index;

  @override
  void initState() {
    super.initState();
    _index = widget._index;
  }

  /// Helps the user go to the next question
  void onNext() {
    setState(() {
      _index = _index! + 1;
    });
  }

  /// Helps the user go to the previous question
  void onPrevious() {
    setState(() {
      _index = _index! - 1;
    });
  }

  /// Defines the view
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Question ${_index! + 1}')
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
                        Text(widget._quiz.questions[_index!].stem),
                        const SizedBox(
                          height: 20,
                        ),
                        widget._quiz.questions[_index!].runtimeType == FillInQuestion ? 
                          FillInAnswer(question: widget._quiz.questions[_index!] as FillInQuestion) :
                          MultipleChoiceAnswer(question: widget._quiz.questions[_index!] as MultipleChoiceQuestion),
                        const SizedBox(height: 20),
                        widget._quiz.questions[_index!].figureURL == null ?
                          const SizedBox() :
                          Image.network(
                            widget._api.getQuestionFigureURL(widget._quiz.questions[_index!].figureURL!),
                            color: Colors.white,
                          )
                      ],
                    )
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton.filled(
                      onPressed: _index! >= widget._quiz.length - 1 ? null : onNext,
                      child: const Text('Next'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: CupertinoButton(
                      onPressed: _index! <= 0 ? null : onPrevious,
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

/// Widget for displaying a Fill In answer
class FillInAnswer extends StatefulWidget {
  final FillInQuestion _question;

  /// Initializes the widget
  const FillInAnswer({Key? key, required question}) :
    _question = question,
    super(key: key)
  ;

  @override
  State<FillInAnswer> createState() => _FillInAnswer();
}

/// State of FillInAnswer widget
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

  /// Initializes the text controller for the input
  void initTextController() {
    _textController = TextEditingController(
      text: widget._question.userAnswer
    );

    _textController!.addListener(() {
      widget._question.userAnswer = _textController!.text;
    });
  }

  /// Disposes of the text controller for the input
  void disposeTextController() {
    _textController!.dispose();
  }

  /// Defines view
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

/// Widget for displaying a Multiple Choice quesiton
class MultipleChoiceAnswer extends StatefulWidget {
  final MultipleChoiceQuestion _question;

  /// Initializes the widget
  const MultipleChoiceAnswer({Key? key, required question}) : 
    _question = question,
    super(key: key);
 
  @override
  State<MultipleChoiceAnswer> createState() => _MultipleChoiceAnswer();
}

/// State of MultipleChoideAnswer widget
class _MultipleChoiceAnswer extends State<MultipleChoiceAnswer> {
  void onRadioChanged(int i) {
    setState(() {
      widget._question.userAnswer = i;
    });
  }

  List<CupertinoButton> _radioOptions() {
    List<CupertinoButton> rtn = [];

    for (var i = 0; i < widget._question.choices.length; i++) {
      rtn.add(
        CupertinoButton(
          padding: const EdgeInsets.symmetric(vertical: 10),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(
                widget._question.userAnswer == i + 1 ?
                  CupertinoIcons.check_mark_circled :
                  CupertinoIcons.circle
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  widget._question.choices[i],
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

  /// Defines the view
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _radioOptions()
    );
  }
}