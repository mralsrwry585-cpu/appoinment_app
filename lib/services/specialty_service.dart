import 'package:dio/dio.dart';
import '../models/specialty.dart';
import './dio_client.dart';

class SpecialtyService {
  final Dio _dio = DioClient().instance;

  Future<List<Specialty>> getSpecialties() async {
    try {
      final response = await _dio.get('/specialties/');
      return (response.data as List)
          .map((json) => Specialty.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('فشل جلب التخصصات');
    }
  }
}
