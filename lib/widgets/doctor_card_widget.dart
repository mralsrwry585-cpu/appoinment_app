import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/doctor.dart';

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    super.key,
    required this.height,
    required this.width,
    required this.doctor,
  });

  final double height;
  final double width;
  final Doctor doctor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('object');
        Navigator.pushNamed(context, '/dr_details', arguments: doctor);
       
      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xFF0D00FF), width: 2),
          borderRadius: BorderRadius.circular(13),
        ),
        height: height + 10,
        child: Container(
          margin: EdgeInsets.all(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(17),
                  image: DecorationImage(
                    image: (doctor.profileImage != null &&
                            doctor.profileImage!.startsWith('http'))
                        ? NetworkImage(doctor.profileImage!)
                        : AssetImage(doctor.profileImage ?? 'assets/images/logo.png')
                            as ImageProvider,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 9),

              // DATA HERE
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'د. ${doctor.fullName}',
                    style: TextStyle(
                      fontFamily: 'almarai',
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                   doctor.specialty.name,
                    style: TextStyle(
                      fontFamily: 'almarai',
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${doctor.experienceYears} سنة خبرة',
                        style: TextStyle(fontFamily: 'almarai', fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Icon(Icons.star, color: Colors.amber),
                      Text(
                        ' ${doctor.rate}',
                        style: TextStyle(fontSize: 15, fontFamily: 'almarai'),
                      ),
                      SizedBox(width: 15),
                      Icon(
                        Icons.location_searching_outlined,
                        color: Colors.amber,
                        size: 18,
                      ),

                      Text(
                        doctor.clinic.city,
                        style: TextStyle(
                          fontFamily: 'almarai',
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
