import 'package:quiz_app/models/results.dart';
import 'package:quiz_app/models/score.dart';


/// Contains the information for a question.
abstract class Question {
  /// The prompt to the question.
  String get stem;
  /// Returns a score indicating the performance
  /// of the user based on their answers.
  QuestionResult evaluate();
}