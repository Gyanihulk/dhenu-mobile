import '../base/base_exception.dart';

const String baseUrl = "https://dhenu.chardhamstays.com/api";
const String registerEndpoint = "$baseUrl/user/register";


class Resource<T> {
  Status? status;
  T? data;
  BaseException? exception;

  Resource.loading() : status = Status.LOADING;
  Resource.success(this.data) : status = Status.SUCCESS;
  Resource.error(this.exception) : status = Status.ERROR;
}

enum Status { LOADING, SUCCESS, ERROR }
