class Failure {
  final String message;

  Failure(this.message);

  String failureMessage() {
    return 'Failure: $message';
  }
}
