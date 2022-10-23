/// Model class that indicates the response from the server.
class LoginResponse {
  final bool _response;
  final String? _reason;

  /// True if the request was successful and user was authenticated.
  /// False otherwise
  bool get response => _response;
  /// If the response field is false, it returns a String with the reason
  /// it failed. If the response was true, this field is null.
  String? get reason => _reason;

  /// Initializes the object.
  LoginResponse(this._response, this._reason);
}