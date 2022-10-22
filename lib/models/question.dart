import 'package:quiz_app/models/question_result.dart';

/// Contains the information for a question.
abstract class Question {
  /// The prompt to the question.
  String get stem;
  String? get figureURL;
  /// Returns a score indicating the performance
  /// of the user based on their answers.
  QuestionResult evaluate();

  Question clone();
}