import 'package:flutter/cupertino.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:quiz_app/models/quiz.dart';
import 'package:quiz_app/views/question_screen.dart';
import 'package:quiz_app/views/result_screen.dart';

/// Widget for displaying a summary of the questions of a quiz
class QuizScreen extends StatefulWidget {
  final Quiz _quiz;

  /// Initializes the widget
  const QuizScreen({Key? key, required quiz}) :
    _quiz = quiz,
    super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreen();
}

/// State of QuizScreen
class _QuizScreen extends State<QuizScreen> {
  void _onNavigate(int index) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (BuildContext context) => QuestionScreen(
          quiz: widget._quiz,
          index: index,
        )
      )
    )
      .then((value) => setState(() {}))
    ;
  }

  /// Defines the view
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Quiz'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('Submit'),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(builder: (BuildContext context) => ResultScreen(quizResult: widget._quiz.evaluate(),))
                );
              }
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return QuizCard(
                  stem: widget._quiz.questions[index].stem,
                  index: index + 1,
                  onTap: () {_onNavigate(index);},
                  userAnswer: widget._quiz.questions[index].userAnswer,
                );
              },
              childCount: widget._quiz.length,
            )
          )
        ],
      )
    );
  }
}

/// Widget to show the summary of a question
class QuizCard extends StatelessWidget {
  final String _stem;
  final int _index;
  final dynamic _userAnswer;
  final VoidCallback _onTap;

  /// Initializes the widget
  const QuizCard({
    Key? key,
    required stem,
    required index,
    required onTap,
    required userAnswer
  }) :
    _stem = stem,
    _index = index,
    _onTap = onTap,
    _userAnswer = userAnswer,
    super(key: key);

  /// Defines the view
  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text('Question $_index'),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(_stem, overflow: TextOverflow.ellipsis)
          )
        ]
      ),
      onTap: _onTap,
      leading: Icon(
        _userAnswer == null ?
          CupertinoIcons.circle :
          CupertinoIcons.check_mark_circled
      ),
      trailing: const Icon(
        CupertinoIcons.forward
      )
    );
  }
}