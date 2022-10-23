import 'package:cupertino_list_tile/cupertino_list_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/quiz_result.dart';

class ResultScreen extends StatelessWidget {
  final QuizResult _quizResult;

  const ResultScreen({Key? key, required quizResult}) :
    _quizResult = quizResult,
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Results (${_quizResult.score.points}/${_quizResult.score.maxPoints})'),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final questionResult = _quizResult.questionResults[index];

                return CupertinoListTile(
                  leading:
                    questionResult.score.points == questionResult.score.maxPoints ?
                      const Icon(
                        CupertinoIcons.check_mark_circled,
                        color: Colors.green,
                      ) :
                      Icon(
                        CupertinoIcons.circle,
                        color: Colors.grey[800]
                      ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Text('Question ${index + 1}'),
                      const SizedBox(height: 10),
                      Text(
                        questionResult.stem
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Answer: ',
                        style: TextStyle(color: Colors.pink)
                      ),
                      Text(
                        questionResult.answer,
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Your answer: ',
                        style: TextStyle(color: Colors.pink)
                      ),
                      Text(
                        questionResult.userAnswer ?? 'N/A',
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Score: ',
                        style: TextStyle(color: Colors.pink)
                      ),
                      Text(
                        '${questionResult.score.points}/${questionResult.score.maxPoints}',
                        style: const TextStyle(
                          color: Colors.grey
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                  trailing: const SizedBox(),
                );
              },
              childCount: _quizResult.questionResults.length,
            )
          )
        ],
      )
    );
  }
}