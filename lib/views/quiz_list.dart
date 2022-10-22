import 'package:flutter/cupertino.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:quiz_app/views/question.dart';
import 'package:quiz_app/views/results.dart';

class QuizListScreen extends StatefulWidget {
  final quiz;
  const QuizListScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizListScreen> createState() => _QuizListScreen();
}

class _QuizListScreen extends State<QuizListScreen> {
  void onNavigate(int index) {
    Navigator.push(
      context,
      CupertinoPageRoute(
          builder: (BuildContext context) => QuestionScreen(
          quiz: widget.quiz,
          index: index,
        )
      )
    )
      .then((value) => onPop())
    ;
  }

  void onPop() {
    setState(() {});
  }

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
                  CupertinoPageRoute(builder: (BuildContext context) => ResultsScreen(quizResult: widget.quiz.evaluate(),))
                );
              }
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return QuizCard(
                  stem: widget.quiz.questions[index].stem,
                  index: index + 1,
                  onTap: () {onNavigate(index);},
                  userAnswer: widget.quiz.questions[index].userAnswer,
                );
              },
              childCount: widget.quiz.length,
            )
          )
        ],
      )
    );
  }
}

class QuizCard extends StatelessWidget {
  final String stem;
  final int index;
  final userAnswer;
  final VoidCallback onTap;

  const QuizCard({
    Key? key,
    required this.stem,
    required this.index,
    required this.onTap,
    required this.userAnswer
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text('Question $index'),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(stem, overflow: TextOverflow.ellipsis)
          )
        ]
      ),
      onTap: onTap,
      leading: Icon(
        userAnswer == null ?
          CupertinoIcons.circle :
          CupertinoIcons.check_mark_circled
      ),
      trailing: const Icon(
        CupertinoIcons.forward
      )
    );
  }
}