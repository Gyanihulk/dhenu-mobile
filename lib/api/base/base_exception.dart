class BaseException {
  int? code;
  String? message;
  String? response;
  String? request;

  BaseException(this.code, this.message, {this.request, this.response});
}
