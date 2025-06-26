import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  static final Dio dio = Dio(
    BaseOptions(
      baseUrl: 'https://df90-103-194-173-96.ngrok-free.app/api',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Accept': 'application/json',
      },
    ),
  )..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('access_token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
      onError: (DioException e, handler) async {
        if (e.response?.statusCode == 401) {
          final prefs = await SharedPreferences.getInstance();
          final refreshToken = prefs.getString('refresh_token');
          if (refreshToken != null) {
            try {
              final refreshResponse =
                  await dio.post('/auth/refresh_token', data: {
                'refresh_token': refreshToken,
              });
              final newToken = refreshResponse.data['access_token'];
              await prefs.setString('access_token', newToken);
              e.requestOptions.headers['Authorization'] = 'Bearer $newToken';
              final cloneReq = await dio.fetch(e.requestOptions);
              return handler.resolve(cloneReq);
            } catch (_) {
              await prefs.clear();
            }
          }
        }
        handler.next(e);
      },
    ));
}
