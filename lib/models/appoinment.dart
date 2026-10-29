import 'package:flutter_application_4/models/appointment_type.dart';

class Appointment {
  String id;
  String patientId;
  String doctorId;
  AppointmentType type;
  DateTime dateTime;
  String? notes; // يكتبها المريض

  Appointment({
    required this.id,
    required this.patientId,
    required this.doctorId,
    required this.type,
    required this.dateTime,
    this.notes,
  });
}
