import 'package:quiz_app/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:quiz_app/utilities/api_decoder.dart';
import '../models/login_data.dart';

class APIUtil {
  static const String url = 'www.cs.utep.edu';
  static const String authenticatePath = '/cheon/cs4381/homework/quiz/login.php';
  final _decoder = APIDecoder();

  Future<LoginResponse> validateUser(LoginData loginData) async {
    var response = await http.get(Uri.https(url, authenticatePath, {'user': loginData.username, 'pin': loginData.pin}));
    return _decoder.decodeAuthResponse(response);
  }
}