import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quiz_app/models/login_data.dart';
import 'package:quiz_app/models/question_pool.dart';
import 'package:quiz_app/utilities/api_util.dart';
import 'package:quiz_app/views/quiz_setup_screen.dart';

/// View for the home screen
class HomeScreen extends StatelessWidget {
  final LoginData _loginData;
  const HomeScreen({super.key, required loginData}) : _loginData = loginData;

  /// Defines the layout of the home screen
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: CustomScrollView(
        slivers: <Widget>[
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Home'),
          ),
          SliverFillRemaining(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(30),
                  child: QuizInfoWidget(loginData: _loginData),
                )
              ]
            )
          )
        ],
      )
    );
  }
}

/// Class that represents the widget that shows the number of
/// questions and the prompt to start a quiz
class QuizInfoWidget extends StatefulWidget {
  final LoginData _loginData;
  final _api = APIUtil();

  ///  Initializes the object
  QuizInfoWidget({Key? key, required loginData}) :
    _loginData = loginData,
    super(key: key);

  @override
  State<QuizInfoWidget> createState() => _QuizInfoWidget();
}

/// State of QuizInfoWidget
class _QuizInfoWidget extends State<QuizInfoWidget> {
  late final Future<QuestionPool> _questionPool;

  /// Initializes the api call to retrieve the questions
  @override
  void initState() {
    super.initState();
    _questionPool = widget._api.getQuestions(widget._loginData);
  }

  /// Defines the view for the widget
  @override
  Widget build(BuildContext context) {    
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        color: Colors.grey[900]
      ),
      child: Column(
        children: [
          const Text(
            'Questions found',
            style: TextStyle(fontFamily: 'Alkalami', fontSize: 20, color: Colors.grey),
            textAlign: TextAlign.start,
          ),
          FutureBuilder<QuestionPool>(
            future: _questionPool,
            builder: (BuildContext context, AsyncSnapshot<QuestionPool> snapshot) {
              if(snapshot.hasData) {
                return Text(
                  '${snapshot.data!.length}',
                  style: const TextStyle(fontFamily: 'Alkalami', fontSize: 60)
                );
              } else {
                return const Text(
                  '...',
                  style: TextStyle(fontFamily: 'Alkalami', fontSize: 60)
                );
              }
            }
          ),
          SizedBox(
            width: double.infinity,
            child: FutureBuilder<QuestionPool>(
              future: _questionPool,
              builder: (BuildContext context, AsyncSnapshot<QuestionPool> snapshot) {
                if(snapshot.hasData) {
                  return CupertinoButton.filled(
                    onPressed: () => Navigator.push(
                      context,
                      CupertinoPageRoute(builder: (BuildContext context) => QuizSetupScreen(questionPool: snapshot.data!,))
                    ),
                    child: const Text('Take quiz'),
                  );
                } else {
                  return const CupertinoButton.filled(
                    onPressed: null,
                    child: Text('Loading'),
                  );
                }
              }
            )
          )
        ],
      )
    );
  }
}