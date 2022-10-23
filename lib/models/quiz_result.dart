import 'package:quiz_app/models/question_result.dart';
import 'package:quiz_app/models/score.dart';

/// Model class that allows the user to compare their answers to the
/// correct answers. It also provides a score representing the user's
/// performance on the quiz
class QuizResult {
  final List<QuestionResult> _questionResults;
  final Score _score;
  /// Returns a list of results for each question in the quiz
  List<QuestionResult> get questionResults => _questionResults;
  /// Returns the score of the user in the quiz
  Score get score => _score;

  /// Initializes the object
  QuizResult(this._questionResults, this._score);
}