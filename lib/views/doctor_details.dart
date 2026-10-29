import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/doctor.dart';
import 'package:flutter_application_4/views/booking_view.dart';
// //import 'package:flutter_application_4/views/booking_view.dart';
// import 'package:flutter_application_4/views/main_view.dart';

class DoctorDetails extends StatefulWidget {
  const DoctorDetails({super.key});

  @override
  State<DoctorDetails> createState() => _DoctorDetailsState();
}

class _DoctorDetailsState extends State<DoctorDetails> {
  late Doctor doctor;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // استلام كائن Doctor من الـ arguments
    doctor = ModalRoute.of(context)!.settings.arguments as Doctor;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        centerTitle: true,
        title: const Text(
          'تفاصيل الدكتور',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'almarai',
            color: Colors.black,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // صورة الطبيب
          Container(
            width: double.infinity,
            height: screenHeight * 0.3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: DecorationImage(
                image: (doctor.profileImage != null &&
                        doctor.profileImage!.startsWith('http'))
                    ? NetworkImage(doctor.profileImage!)
                    : (doctor.profileImage != null
                        ? AssetImage(doctor.profileImage!)
                        : const AssetImage('assets/images/logo.png'))
                          as ImageProvider,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // اسم الطبيب وتخصصه
          Text(
            'د. ${doctor.fullName}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'almarai',
              fontSize: 28,
            ),
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                doctor.specialty.name,
                style: TextStyle(
                  fontFamily: 'almarai',
                  fontSize: 20,
                  color: Colors.grey[700],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Icon(Icons.location_on, color: Colors.red),
                  const SizedBox(width: 4),
                  Text(
                    '${doctor.clinic.city},',
                    style: const TextStyle(fontFamily: 'almarai'),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    doctor.clinic.address,
                    style: const TextStyle(fontFamily: 'almarai'),
                  ),
                  const SizedBox(width: 3),
                  Text(
                    doctor.clinic.name,
                    style: const TextStyle(fontFamily: 'almarai'),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // تقييم وخبرة وموقع
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text("${doctor.rate}"),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.work, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    "${doctor.experienceYears} سنة خبرة",
                    style: const TextStyle(fontFamily: 'almarai'),
                  ),
                ],
              ),
              Row(
                children: [
                  const Icon(Icons.phone, color: Colors.blue),
                  const SizedBox(width: 4),
                  Text(
                    doctor.phone,
                    textDirection: TextDirection.ltr,
                    style: const TextStyle(fontFamily: 'almarai'),
                  ),
                ],
              ),
            ],
          ),

          const Divider(height: 32),

          // نبذة عن الطبيب
          const Text(
            "نبذة عن الدكتور",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'almarai',
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            doctor.bio,
            style: const TextStyle(fontFamily: 'almarai', fontSize: 18),
          ),

          const Divider(height: 32),

          // التعليم والمؤهلات
          const Text(
            "التعليم والمؤهلات",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'almarai',
              fontSize: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            doctor.eduCv,
            style: const TextStyle(fontFamily: 'almarai', fontSize: 18),
          ),

          const Divider(height: 32),

          // أوقات العمل
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "أوقات العمل",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'almarai',
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: 8),

              // تحقق من null قبل map
              if (doctor.schedules.isNotEmpty)
                ...doctor.schedules.map((schedule) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.access_time,
                          color: Colors.blue,
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "${schedule.dayOfWeek}: ${schedule.startTime} - ${schedule.endTime}",
                          style: const TextStyle(
                            fontFamily: 'almarai',
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList()
              else
                const Text(
                  "لا توجد أوقات عمل متاحة",
                  style: TextStyle(
                    fontFamily: 'almarai',
                    fontSize: 18,
                    color: Colors.grey,
                  ),
                ),
            ],
          ),

          const SizedBox(height: 24),

          // زر الحجز
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BookingFormPage(doctor: doctor),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(11),
                color: const Color(0xFF0F67FF),
              ),
              width: double.infinity,
              height: 60,
              margin: const EdgeInsets.symmetric(horizontal: 1),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.event_available_sharp,
                    size: 24,
                    color: Colors.white,
                  ),
                  SizedBox(width: 8),
                  Text(
                    "حجز موعد",
                    style: TextStyle(
                      fontFamily: "almarai",
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
