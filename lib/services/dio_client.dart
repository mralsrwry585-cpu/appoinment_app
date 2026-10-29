import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_4/views/globals.dart';
import 'package:flutter_application_4/views/login_view.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DioClient {
  final Dio _dio = Dio(
    
    BaseOptions(
      baseUrl: "https://desraj.in/api.php", // رابط الباك اند المحاكي
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      contentType: 'application/json',
    ),
  );

  final _storage = const FlutterSecureStorage();

  DioClient() {
    // إضافة Interceptor لإرسال التوكن تلقائياً في كل طلب وتوجيه المسار لـ api.php دون الحاجة لـ htaccess
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.baseUrl.endsWith('.php')) {
          final targetRoute = options.path;
          options.path = '${options.baseUrl}?route=$targetRoute';
          options.baseUrl = '';
        }
        String? token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
      onError: (DioException e, handler) async {
        // هنا يمكنك معالجة أخطاء 401 (انتهت الجلسة) وتوجيه المستخدم لتسجيل الدخول
            if (e.response?.statusCode == 401) {
        await FlutterSecureStorage().delete(key: 'token');

        // استخدم navigatorKey بدل context
        navigatorKey.currentState?.pushAndRemoveUntil(
          MaterialPageRoute(builder: (_) => LoginView()),
          (route) => false,
        );
      }
        return handler.next(e);
      },
    ));
  }

  Dio get instance => _dio;
}