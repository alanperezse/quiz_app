import 'package:http/http.dart' as http;
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/models/question_pool.dart';
import 'package:quiz_app/utilities/api_decoder.dart';
import '../models/login_data.dart';

class APIUtil {
  static const String url = 'www.cs.utep.edu';
  static const String authenticatePath = '/cheon/cs4381/homework/quiz/login.php';
  static const String quizPath = '/cheon/cs4381/homework/quiz/get.php';
  static const String figurePath = '/cheon/cs4381/homework/quiz/figure.php';
  final _decoder = APIDecoder();

  void validateUser(LoginData loginData, Function onSuccess, Function onFailure) async {
    var response = await http.get(
      Uri.https(url, authenticatePath, {
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

  Future<QuestionPool> getQuestions(LoginData loginData) async {
    List<Question> questions = [];

    for(var i = 1; i < 100; i++) {
      var quizNum = _quizPostFix(i);
      try {
        var response = await http.get(
          Uri.https(url, quizPath, {
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

  String getQuestionFigureURL(String figureURL) {
    print('https://$url$figurePath?name=$figureURL');
    return 'https://$url$figurePath?name=$figureURL';
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