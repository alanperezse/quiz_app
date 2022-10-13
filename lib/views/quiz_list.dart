import 'package:flutter/cupertino.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:quiz_app/views/question.dart';
import 'package:quiz_app/models/quiz.dart';

class QuizListScreen extends StatefulWidget {
  final Quiz quiz;
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
    );
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
              onPressed: () {}
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return QuizCard(
                  stem: widget.quiz.questions.toList()[index].stem,
                  index: index + 1,
                  onTap: () {onNavigate(index);},
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
  final VoidCallback onTap;

  const QuizCard({Key? key, required this.stem, required this.index, required this.onTap}) : super(key: key);

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
      leading: const Icon(
        CupertinoIcons.check_mark_circled
      ),
      trailing: const Icon(
        CupertinoIcons.forward
      )
    );
  }
}