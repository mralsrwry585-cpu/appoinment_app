import 'package:flutter_application_4/models/common.dart';

import 'clinic.dart';
import 'specialty.dart';


class Doctor {
  final String phone;
  final String fullName;
  final String email;
  final String bio;
  final String eduCv;
  final double rate;
  final int experienceYears;
  final String licenseNumber;
  final String licenseIssuer;
  final Clinic clinic;
  final Specialty specialty;
  final List<WorkSchedule> schedules;
  final String? profileImage;

  Doctor({
    required this.phone,
    required this.fullName,
    required this.email,
    required this.bio,
    required this.eduCv,
    required this.rate,
    required this.experienceYears,
    required this.licenseNumber,
    required this.licenseIssuer,
    required this.clinic,
    required this.specialty,
    required this.schedules,
    this.profileImage,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => Doctor(
        phone: json['phone'] ?? '',
        fullName: json['full_name'] ?? '',
        email: json['email'] ?? '',
        bio: json['bio'] ?? '',
        eduCv: json['edu_cv'] ?? '',
        rate: (json['rate'] ?? 0).toDouble(),
        experienceYears: json['experience_years'] ?? 0,
        licenseNumber: json['license_number'] ?? '',
        licenseIssuer: json['license_issuer'] ?? '',
        clinic: Clinic.fromJson(json['clinic'] ?? {}),
        specialty: Specialty.fromJson(json['specialty_rel'] ?? {}),
        schedules: json['schedules'] != null
            ? List<WorkSchedule>.from(
                json['schedules'].map((x) => WorkSchedule.fromJson(x)))
            : [],
        profileImage: json['profile_image'],
      );

  Map<String, dynamic> toJson() => {
        'phone': phone,
        'full_name': fullName,
        'email': email,
        'bio': bio,
        'edu_cv': eduCv,
        'rate': rate,
        'experience_years': experienceYears,
        'license_number': licenseNumber,
        'license_issuer': licenseIssuer,
        'clinic': clinic.toJson(),
        'specialty_rel': specialty.toJson(),
        'schedules': schedules.map((x) => x.toJson()).toList(),
        'profile_image': profileImage,
      };
}
