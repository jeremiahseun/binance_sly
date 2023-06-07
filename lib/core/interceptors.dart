import 'package:dio/dio.dart';
import 'package:simple_logger/simple_logger.dart';

class DioInterceptor implements Interceptor {
  final log = SimpleLogger();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    log.info('ENDPOINT: ${err.requestOptions.uri}');
    log.info('STATUSCODE: ${err.error}');
    log.info('MESSAGE: ${err.response?.data ?? err.message}');
    handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    log.info('METHOD: ${options.method}');
    log.info('ENDPOINT: ${options.uri}');
    log.info('HEADERS: ${options.headers}');
    log.info('DATA: ${options.data ?? options.queryParameters}');
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log.info('ENDPOINT: ${response.requestOptions.uri}');
    log.info('STATUSCODE: ${response.statusCode}');
    log.info('DATA: ${response.data}');
    handler.next(response);
  }
}
