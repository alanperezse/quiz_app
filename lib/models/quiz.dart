import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/quiz_result.dart';
import 'package:quiz_app/models/question_result.dart';
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
  QuizResult evaluate() {
    var score = Score(0, 0);
    List<QuestionResult> questionResults = [];
    for(var question in _questions) {
      var result = question.evaluate();
      questionResults.add(result);
      score += result.score;
    }

    return QuizResult(
      questionResults,
      score
    );
  }
}