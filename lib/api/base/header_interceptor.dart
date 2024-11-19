import 'package:dhenu_dharma/utils/constants/api_constants.dart';
import 'package:http_interceptor/http_interceptor.dart';

class HeaderInterceptor extends InterceptorContract {
  @override
  Future<BaseRequest> interceptRequest({required BaseRequest request}) {
    request.headers.addAll({
      ApiConstants.kContentType: ApiConstants.kApplictionJson,
    });
    return Future.value(request);
  }

  @override
  Future<BaseResponse> interceptResponse(
      {required BaseResponse response}) async {
    return Future.value(response);
  }
}
