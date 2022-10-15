import 'package:flutter/cupertino.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: Text('Results'),
          ),
          SliverFillRemaining(
            child: Text('Results'),
          )
        ],
      )
    );
  }
}