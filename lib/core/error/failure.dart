class Failure {
  final String message;

  Failure(this.message);

  @override
  String failureMessage() {
    return 'Failure: $message';
  }
}
