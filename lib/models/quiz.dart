import 'package:quiz_app/models/question.dart';
import 'score.dart';


/// Contains a set of questions that the user must
/// answer for evaluation.
class Quiz {
  final List<Question> _questions;

  /// Immutable set of questions.
  List<Question> get questions => _questions;

  /// Number of questions.
  int get length => questions.length;

  /// Creates a Quiz objects containing the questions
  /// provided.
  Quiz(this._questions);

  /// Returns the sum of the user performance for
  /// the questions.
  Score evaluate() {
    var score = Score(0, 0);
    for(var question in _questions) {
      score += question.evaluate();
    }

    return score;
  }
}