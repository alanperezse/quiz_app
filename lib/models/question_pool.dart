import '../models/question.dart';


/// Holds a list of questions and allows a user
/// to retrieve them for later use.
class QuestionPool {
  final List<Question> questions;

  /// Immutable list of questions.
  /// Number of questions.
  int get length => questions.length;

  const QuestionPool([this.questions = const []]);
  
  /// Retrieves a random set of questions from
  /// the pool.
  List<Question> selectRandomQuestions(int num) {
    var randomList = questions.toList();
    randomList.shuffle();
    return randomList.sublist(0, num);
  }

  void addQuestions(List<Question> newQuestions) {
    questions.addAll(newQuestions);
  }
}