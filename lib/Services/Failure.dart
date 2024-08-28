abstract class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

class ServerFailure implements Failure {
  @override
  String get message => "خطأ في الاتصال";
}

class InternetFailure implements Failure {
  @override
  String get message => "لايوجد اتصال في الانترنت";
}

class GlobalFailure implements Failure {
  @override
  String get message => "حدث خطأ غير متوقع، يرجى إعادة المحاولة";
}

class ResultFailure implements Failure {
  @override
  final String message;

  ResultFailure(this.message);

  @override
  String toString() => message;
}
