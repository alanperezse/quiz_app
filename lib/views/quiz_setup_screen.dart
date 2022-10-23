import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:quiz_app/models/question_pool.dart';
import 'package:quiz_app/views/quiz_screen.dart';

import '../models/quiz.dart';

/// Widget for displaying the setup before entering a quiz
class QuizSetupScreen extends StatefulWidget {
  final QuestionPool _questionPool;

  /// Initializes the widget
  const QuizSetupScreen({Key? key, required questionPool}) :
    _questionPool = questionPool,
    super(key: key);

  @override
  State<QuizSetupScreen> createState() => _QuizSetupScreen();
}

/// State of QuizSetupScreen widget
class _QuizSetupScreen extends State<QuizSetupScreen> {
  int? _numQuestions;
  late final List<int> _pickerOptions;

  /// Helps reduce time for build
  @override
  void initState() {
    super.initState();
    _numQuestions = math.min(5, widget._questionPool.length);
    _pickerOptions = List<int>.generate(widget._questionPool.length, (index) => index + 1);
  }

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
          // Use a SafeArea widget to avoid system overlaps.
          child: SafeArea(
            top: false,
            child: child,
          ),
        )
    );
  }

  /// Defines view
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: [
          CupertinoSliverNavigationBar(
            largeTitle: const Text('Quiz Setup'),
            trailing: CupertinoButton(
              padding: EdgeInsets.zero,
              child: const Text('Next'),
              onPressed: () {
                Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (BuildContext context) {
                      final randomQuestions = widget._questionPool.selectRandomQuestions(_numQuestions!);
                      final quiz = Quiz(randomQuestions);
                      return QuizScreen(quiz: quiz);
                    }
                  )
                );
              }
            ),
          ),
          SliverFillRemaining(
            child: CupertinoFormSection(
              header: const Text('Setup'),
              children: [
                CupertinoFormRow(
                  prefix: const PrefixWidget(
                    icon: CupertinoIcons.list_number,
                    title:  'Questions',
                    color: Colors.pink
                  ),
                  child: CupertinoButton(
                    child: Container(
                      alignment: Alignment.centerRight,
                      width: double.infinity,
                      child: Text('$_numQuestions')
                    ),
                    onPressed: () {
                      _showDialog(
                        CupertinoPicker(
                          magnification: 1.22,
                          squeeze: 1.2,
                          itemExtent: 32.0,
                          // This is called when selected item is changed.
                          onSelectedItemChanged: (int selectedItem) {
                            setState(() {
                              _numQuestions = selectedItem + 1;
                            });
                          },
                          children:
                            List<Widget>.generate(_pickerOptions.length, (int index) {
                              return Center(
                                child: Text('${_pickerOptions[index]}'),
                              );
                            }),
                        ),
                      );
                    },
                  )
                )
              ],
            )
          )
        ],
      )
    );
  }
}

/// Widget for the prefixes to each option for a quiz
class PrefixWidget extends StatelessWidget {
  final IconData _icon;
  final String _title;
  final Color _color;

  /// Initializes the widget
  const PrefixWidget({
    super.key,
    required icon,
    required title,
    required color,
  }) :
    _icon = icon,
    _title = title,
    _color = color
  ;

  /// Defines the view
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(4.0),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Icon(_icon, color: CupertinoColors.white),
        ),
        const SizedBox(width: 15),
        Text(_title)
      ],
    );
  }
}