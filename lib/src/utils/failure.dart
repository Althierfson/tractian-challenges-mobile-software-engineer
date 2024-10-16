abstract class Failure {
  String get message;
}

class UnexpectedFailure implements Failure {
  @override
  String get message => 'Unexpected error! Please try again later.';
}

class ServerFailure implements Failure {
  @override
  String get message => 'Server error! Please try again later.';
}