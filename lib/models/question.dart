import 'package:quiz_app/models/question_result.dart';

/// Contains the information for a question.
abstract class Question {
  /// The prompt to the question.
  String get stem;
  String? get figureURL;

  /// Retrieves the answer provided by the user
  get userAnswer;

  /// Returns a score indicating the performance
  /// of the user based on their answers.
  QuestionResult evaluate();

  /// Returns a deep copy of the current instance
  Question clone();
}