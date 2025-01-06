import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class LoggerInterceptors extends Interceptor {
  Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: 0,
      colors: true,
      printEmojis: true,
    ),
  );

  @override
  void onError(DioException dioE, ErrorInterceptorHandler handler) {
    final options = dioE.requestOptions;
    final requestPath = '${options.baseUrl} ${options.path}';
    logger.e('${options.method} request ==> $requestPath');
    logger.d('Error type: ${dioE.error} \nError message: ${dioE.message}');
    handler.next(dioE);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final requestPath = '${options.baseUrl} ${options.path}';
    logger.i('${options.method} request ==> $requestPath');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    logger.d('========== LOG ==========\n'
        'STATUSCODE: ${response.statusCode}\n'
        'STATUSMESSAGE: ${response.statusMessage}\n'
        'HEADERS: ${response.headers}\n'
        'Data: ${response.data}\n');
  }
}
