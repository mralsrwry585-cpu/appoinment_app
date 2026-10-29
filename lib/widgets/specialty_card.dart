import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/specialty.dart';

Widget getSpecialtyIcon(String name) {
  switch (name.trim()) {
    case 'أسنان':
      return Text('🦷', style: TextStyle(fontSize: 33));

    case 'اعصاب':
      return Icon(Icons.psychology, size: 33, color: Colors.deepPurple);

    case 'أطفال':
      return Icon(Icons.child_care, size: 33, color: Colors.orange);

    case 'قلب':
      return Icon(Icons.favorite, size: 33, color: Colors.red);

    default:
      return Icon(Icons.local_hospital, size: 33, color: Colors.teal);
  }
}

class SpecialtyCard extends StatelessWidget {
  final VoidCallback? onTap;
  final Specialty specialty;
  const SpecialtyCard({super.key, required this.specialty, this.onTap});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.264; // 27% من الشاشة
    double height = width * 1.1; // ارتفاع نسبي للعرض

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(17),
          border: Border.all(color: Color.fromARGB(255, 13, 0, 255), width: 2),
        ),
        width: width,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: width * 0.3,
              backgroundColor: Colors.blue.withOpacity(0.1),
              child: getSpecialtyIcon(specialty.name),
            ),

            SizedBox(height: 8),
            Text(
              specialty.name,
              style: TextStyle(
                fontFamily: 'almarai',
                fontSize: 16,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
