import 'package:quiz_app/models/score.dart';

/// Model class that allows the user to compare their answer to the
/// correct answer. It also provides a score representing the user's
/// performance on the quiz
class QuestionResult {
  final String _stem;
  final String _answer;
  final String? _userAnswer;
  final Score _score;

  /// The prompt to the question
  String get stem => _stem;
  /// The expected answer
  String get answer => _answer;
  /// The user's provided answer
  String? get userAnswer => _userAnswer;
  /// The user's performance given their answer
  Score get score => _score;

  /// Initializes the object
  QuestionResult(this._stem, this._answer, this._userAnswer, this._score);
}