import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:quiz_app/models/quiz.dart';

class QuizListScreen extends StatefulWidget {
  final Quiz quiz;
  const QuizListScreen({Key? key, required this.quiz}) : super(key: key);

  @override
  State<QuizListScreen> createState() => _QuizListScreen();
}

class _QuizListScreen extends State<QuizListScreen> {
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
                return QuizCard(stem: widget.quiz.questions.toList()[index].stem, index: index + 1);
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

  const QuizCard({Key? key, required this.stem, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoListTile(
      title: Text('Question $index'),
      subtitle: Flexible(child: Text(stem, overflow: TextOverflow.ellipsis),),
      onTap: () => () {/** TODO: Jump to new screen*/},
      leading: const Icon(
        CupertinoIcons.circle
      ),
      trailing: const Icon(
        CupertinoIcons.forward
      )
    );
  }
}