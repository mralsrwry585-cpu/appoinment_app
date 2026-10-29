import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/doctor.dart';
import 'package:flutter_application_4/services/patient_service.dart';
import 'package:flutter_application_4/widgets/doctor_card_widget.dart';

class BuildDoctorsFuture extends StatefulWidget {
  final String? specialtyId;
  final String? specialityCity;
  final double? minRating;
  const BuildDoctorsFuture({
    super.key,
    this.specialtyId,
    this.specialityCity,
    this.minRating,
  });

  @override
  State<BuildDoctorsFuture> createState() => _BuildDoctorsFutureState();
}

class _BuildDoctorsFutureState extends State<BuildDoctorsFuture> {
  final PatientService _patientService = PatientService();
  late Future<List<Doctor>> _doctorsFuture;
  @override
  void initState() {
    super.initState();
    _doctorsFuture = _patientService.getDoctors(
      specialtyId: widget.specialtyId,
      city: widget.specialityCity,
      minRating: widget.minRating,
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.27; // 27% من الشاشة
    double height = width * 1.0; // ارتفاع نسبي للعرض

    return FutureBuilder<List<Doctor>>(
      future: _doctorsFuture,
      builder: (context, snapshot) {
        // ⏳ تحميل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Padding(
            padding: EdgeInsets.all(30),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // ❌ خطأ
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Text(
                snapshot.error.toString(),
                style: const TextStyle(fontFamily: 'almarai'),
                textAlign: TextAlign.center,
              ),
            ),
          );
        }

        final doctors = snapshot.data ?? [];

        // 📭 فارغ
        if (doctors.isEmpty) {
          return const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'لا يوجد أطباء متاحون حالياً',
                style: TextStyle(fontFamily: 'almarai'),
              ),
            ),
          );
        }

        // ✅ نجاح
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: 17),
          itemCount: doctors.length,
          separatorBuilder: (_, __) => const SizedBox(height: 15),
          itemBuilder: (context, index) {
            return DoctorCard(
              width: width,
              height: height,
              doctor: doctors[index],
            );
          },
        );
      },
    );
  }
}

//  buildDoctorsFuture({
//   required double width,
//   required double height,
//   required double paddingHorizontal,
//   Future<List<Doctor>>? doctorsFuture,
// }) {
//   return FutureBuilder<List<Doctor>>(
//     future: doctorsFuture,
//     builder: (context, snapshot) {
//       // ⏳ تحميل
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Padding(
//           padding: EdgeInsets.all(30),
//           child: Center(child: CircularProgressIndicator()),
//         );
//       }

//       // ❌ خطأ
//       if (snapshot.hasError) {
//         return Padding(
//           padding: const EdgeInsets.all(20),
//           child: Center(
//             child: Text(
//               snapshot.error.toString(),
//               style: const TextStyle(fontFamily: 'almarai'),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         );
//       }

//       final doctors = snapshot.data ?? [];

//       // 📭 فارغ
//       if (doctors.isEmpty) {
//         return const Padding(
//           padding: EdgeInsets.all(20),
//           child: Center(
//             child: Text(
//               'لا يوجد أطباء متاحون حالياً',
//               style: TextStyle(fontFamily: 'almarai'),
//             ),
//           ),
//         );
//       }

//       // ✅ نجاح
//       return ListView.separated(
//         shrinkWrap: true,
//         physics: const NeverScrollableScrollPhysics(),
//         padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
//         itemCount: doctors.length,
//         separatorBuilder: (_, __) => const SizedBox(height: 15),
//         itemBuilder: (context, index) {
//           return DoctorCard(
//             width: width,
//             height: height,
//             doctor: doctors[index],
//           );
//         },
//       );
//     },
//   );
// }
