import 'package:dio/dio.dart';
import 'package:flutter_application_4/models/booking_request.dart';
//import 'package:flutter_application_4/models/patient.dart';
import '../models/doctor.dart';
//import '../models/booking.dart'; // تأكد من اسم الملف لديك
import 'dio_client.dart';

class PatientService {
  final Dio _dio = DioClient().instance;

  // 1. جلب الأطباء (مع تحويل البيانات إلى Model)
  Future<List<Doctor>> getDoctors({
    String? city,
    String? specialtyId,
    double? minRating,
  }) async {
    try {
      final response = await _dio.get(
        '/doctors/doctors',
        queryParameters: {
          if (city != null) 'city': city,
          if (minRating != null) 'minRating': minRating,
          if (specialtyId != null)
            'specialty_id': specialtyId, // التصفية بالـ ID أدق
        },
      );

      // تحويل قائمة الـ JSON إلى قائمة من كائنات Doctor
      return (response.data as List)
          .map((doctorJson) => Doctor.fromJson(doctorJson))
          .toList();
    } catch (e) {
      throw Exception("فشل جلب قائمة الأطباء: $e");
    }
  }

  Future<BookingRequest> createBookingRequest({
    required String doctorId,
    required String doctorPhone,
    required DateTime requestDate,
    required DateTime appointmentDate,
    required String startTime,
    String? reason,
  }) async {
    try {
      final response = await _dio.post(
        '/bookings/requests',
        data: {
          'doctor_id': doctorId,
          'doctor_phone': doctorPhone,
          'request_date': requestDate.toIso8601String(),
          'appointment_date': appointmentDate.toIso8601String().split('T')[0],
          'start_time': startTime,
          if (reason != null) 'reason': reason,
        },
      );

      return BookingRequest.fromJson(response.data);
    } on DioException catch (e) {
      throw e.response?.data['detail'] ?? "حدث خطأ أثناء إنشاء الطلب";
    }
  }

  // 3️⃣ جلب الطلبات الشخصية للمريض
  Future<List<BookingRequest>> getMyRequests() async {
    try {
      final response = await _dio.get('/bookings/requests');
      return (response.data as List)
          .map((json) => BookingRequest.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("فشل جلب طلبات الحجز");
    }
  }

  // 4️⃣ (اختياري) إذا أردنا جلب طلبات الدكتور
  Future<List<BookingRequest>> getDoctorRequests() async {
    try {
      final response = await _dio.get('/api/v1/patients/doctor/requests');
      return (response.data as List)
          .map((json) => BookingRequest.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception("فشل جلب طلبات الدكتور");
    }
  }
}
