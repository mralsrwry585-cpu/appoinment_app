import 'package:dio/dio.dart';
import 'package:flutter_application_4/models/patient.dart';
//import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dio_client.dart';

class AuthService {
  final Dio _dio = DioClient().instance;
  final _storage = const FlutterSecureStorage();

  Future<Patient?> fetchPatient() async {
    try {
      // final token = await _storage.read(key: 'token');
      // if (token == null) throw Exception('No token found');

      final response = await _dio.get(
        '/patients/me', // ضع رابط الـ API الصحيح
      );

      return Patient.fromJson(response.data);
    } catch (e) {
      print('Error fetching patient: $e');
      rethrow;
    }
  }

  // تسجيل دخول
  Future<Patient?> login(String phone, String password, String role) async {
    try {
      // الـ Login في FastAPI يتطلب إرسال البيانات كـ Form Data وليس JSON
      // final formData = FormData.fromMap({
      //   'phone': phone,
      //   'password': password,
      //   'role':role
      // });

      final response = await _dio.post(
        '/auth/login',
        queryParameters: {'phone': phone, 'password': password, 'role': role},
      );

      if (response.statusCode == 200) {
        String token = response.data['access_token'];
        String role = response.data['role'];

        // حفظ التوكن والدور في الذاكرة الآمنة
        await _storage.write(key: 'token', value: token);
        await _storage.write(key: 'role', value: role);

        final patient = await fetchPatient();
        return patient;
      }
      return null;
    } catch (e) {
      print("Login Error: $e");
      return null;
    }
  }

  // تسجيل مريض جديد
  Future<bool> registerPatient(Map<String, dynamic> patientData) async {
    try {
      final response = await _dio.post(
        '/auth/register/patient',
        data: patientData,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
