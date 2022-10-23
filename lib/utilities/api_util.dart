import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/question_pool.dart';
import 'package:quiz_app/utilities/api_decoder.dart';
import '../models/login_data.dart';

/// Utility class responsible for communicating with the server
class APIUtil {
  static const _url = 'www.cs.utep.edu';
  static const _authenticatePath = '/cheon/cs4381/homework/quiz/login.php';
  static const _quizPath = '/cheon/cs4381/homework/quiz/get.php';
  static const _figurePath = '/cheon/cs4381/homework/quiz/figure.php';
  final _decoder = APIDecoder();

  void validateUser(LoginData loginData, Function onSuccess, Function onFailure) async {
    var response = await http.get(
      Uri.https(_url, _authenticatePath, {
        'user': loginData.username,
        'pin': loginData.pin
      }
    ));
    var parsedResponse = _decoder.decodeAuthResponse(response);
    if (parsedResponse.response) {
      onSuccess(parsedResponse);
    } else {
      onFailure(parsedResponse);
    }
  }

  /// Returns a question pool containing all the questions from all
  /// the quizzes in the server
  Future<QuestionPool> getQuestions(LoginData loginData) async {
    List<Question> questions = [];

    for(var i = 1; i < 100; i++) {
      var quizNum = _quizPostFix(i);
      try {
        var response = await http.get(
          Uri.https(_url, _quizPath, {
            'user': loginData.username,
            'pin': loginData.pin,
            'quiz': 'quiz$quizNum'
          }
        ));

        var newQuestions = _decoder.decodeQuiz(response);
        if (newQuestions == null) {
          break;
        }

        questions.addAll(newQuestions);

      } catch(e) {
        print('Failure while retrieving quiz $quizNum, skipping for now.');
        print(e);
      }
    }
    
    return QuestionPool(questions);
  }

  /// Returns the complete url to retrieve a figure, given the name of the
  /// document in the server
  String getQuestionFigureURL(String figureURL) {
    print('https://$_url$_figurePath?name=$figureURL');
    return 'https://$_url$_figurePath?name=$figureURL';
  }

  /// Given a number in the range [0-99] inclusive, it returns
  /// the String representation of the number using two
  /// characters.
  String _quizPostFix(num val) {
    if (0 > val || val >= 100) throw Error();
    var lst = [];
    for(var i = 0; i < 2; i++) {
      lst.add('${val % 10}');
      val = val ~/ 10;
    }

    return lst.reversed.join('');
  }
}