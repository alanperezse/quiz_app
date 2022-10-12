import 'package:flutter/cupertino.dart';
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
                return Text('$index');
              },
              childCount: widget.quiz.length
            )
          )
        ],
      )
    );
  }
}

