class BookingRequest {
  final String id;
  final String doctorPhone;
  final String patientPhone;
  final String appointmentDate;
  final String startTime;
  final String endTime;
  final String status;
  final String? reason;

  BookingRequest({
    required this.id,
    required this.doctorPhone,
    required this.patientPhone,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    this.reason,
  });

  // هذا المصنع (Factory) هو الأهم لضمان عدم حدوث خطأ عند تحويل البيانات
  factory BookingRequest.fromJson(Map<String, dynamic> json) {
    return BookingRequest(
      id: json['id'] ?? '',
      doctorPhone: json['doctor_phone'] ?? '',
      patientPhone: json['patient_phone'] ?? '',
      appointmentDate: json['appointment_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      status: json['status'] ?? 'pending',
      reason: json['reason'],
    );
  }
}