//인터셉트 기능
import 'package:dio/dio.dart';
import 'package:firest_dongjun/common/const/data.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CustomInterceptor extends Interceptor {
  final FlutterSecureStorage storage;

  CustomInterceptor({
    required this.storage,
  });

  /** 1. 요청 보낼 때,
   * 요청이 보내질때 Header의 값이 true라면
   * 실제 토큰을 저장소에서 가져와서 Token을 최신화 시켜줍니다.
   * 그리고 변경된 토큰을 을 Header로 변경합니다.*/
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    //로그로 사용할 수 있음
    print('[REQ] ${options.method} ${options.uri} ${options.headers['accessToken']}');

    //해더 true라는건 인증 토큰 기간이 짧기 때문에, 인증이 필요한 모든 클래스의 매소드를 최신화 시켜주는 의미입니다.
    if (options.headers['accessToken'] == 'true') {
      options.headers.remove('accessToken');
      final token = await storage.read(key: ACCESS_TOKEN_KEY);
      options.headers.addAll({
        'authorization': 'Bearer $token',
      });
    }
    //여기서 요청을 보냅니다.
    return super.onRequest(options, handler);
  }

  /** 2. 응답을 받았을 때
   * 정상적인 응답일 때 받아옴
   * */
  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print('[RES] ${response.requestOptions.method} ${response.requestOptions.uri}');
    super.onResponse(response, handler);
  }

  /** 3. 에러가 났을 때
   * 401에러 => status code
   * 토큰을 재발급 받는 시도를 하고, 토큰이 재발급 되면 다시 새로운 토큰을 요청한다*/
  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    print('[ERR] ${err.requestOptions.method} ${err.requestOptions.uri}');

    final refreshToken = await storage.read(key: REFRESH_TOKEN_KEY);

    //refreshToken이 없으면 => 에러
    if (refreshToken == null) {
      //에러를 출력하는 방식
      return handler.reject(err);
    }

    // 401 토큰이 잘못되어있다
    final isStatus401 = err.response?.statusCode == 401;
    // 토큰을 최신화 하려다가 에러가 발생한 상황
    final isPathRefresh = err.requestOptions.path == '/auth/token';

    //이 조건은 1. 토큰이 잘못되었으며 2. 최신화가 아닐때
    // => 앱을 구현하는 도중 accessToken의 부분을 파악하지 못했지만, accessToken이 필요한 상황
    // => accessToken을 새로 발급받는 방식
    if (isStatus401 && !isPathRefresh) {
      final dio = Dio();

      try {
        final resp = await dio.post('http://$ip/auth/token',
            options: Options(
              headers: {
                'authorization': 'Bearer $refreshToken',
              },
            ));
        final accessToken = resp.data['accessToken'];

        //err.requestOpions는 onRequest 함수에서 사용한 options의 기능과 동일한 변수를 생성합니다.
        final options = err.requestOptions;

        options.headers.addAll({'authorization': 'Bearer $accessToken'});
        await storage.write(key: ACCESS_TOKEN_KEY, value: accessToken);

        // error와 관련있는 옵션만 받아서 요청을 재전송합니다
        final response = await dio.fetch(options);

        // 에러가 없었던 것처럼 보임
        return handler.resolve(response);
      } on DioError catch (e) {
        return handler.reject(e);
      }
    }

    return handler.reject(err);
  }
}
