import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
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
    return Container (
      padding: const EdgeInsets.all(30),
      child: Row(
        children: [
          Icon(
            CupertinoIcons.circle,
            color: Colors.grey[800],
          ),
          const Icon(
            Icons.check_circle_outlined,
          ),
          const SizedBox(
            width: 15,
          ),
          Flexible(
            child: Text(
              stem,
              overflow: TextOverflow.ellipsis,
            )
          ),
          const SizedBox(
            width: 15,
          ),
          const Icon(
            CupertinoIcons.forward,
            size: 25
          )
        ]
      )
    );
  }
}