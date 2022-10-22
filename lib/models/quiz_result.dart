import 'package:quiz_app/models/question_result.dart';
import 'package:quiz_app/models/score.dart';

class QuizResult {
  final List<QuestionResult> _questionResults;
  final Score _score;
  List<QuestionResult> get questionResults => _questionResults;
  Score get score => _score;
  
  QuizResult(this._questionResults, this._score);
}