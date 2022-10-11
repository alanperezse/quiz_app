/// Immutable representation of the user performance.
class Score {
  final num _points;
  final num _maxPoints;

  Score(this._points, this._maxPoints);

  /// User performance
  num get points => _points;
  /// Best possible performance
  num get maxPoints => _maxPoints;
  
  /// Takes in a Score object and adds the respective
  /// fields, returning a new Score object.
  Score operator +(other) {
    if (other.runtimeType != Score) throw TypeError();
    var newScore = _points + other.points;
    var newMaxScore = _maxPoints + other.maxPoints;
    return Score(newScore, newMaxScore);
  }
}