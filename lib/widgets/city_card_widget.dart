import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/city_summary.dart';

class CityCardWidget extends StatelessWidget {
  final CitySummary city;
  final VoidCallback? onTap;

  const CityCardWidget({super.key, required this.city, this.onTap});

  @override
  Widget build(BuildContext context) {
    // تحديد الألوان بناءً على حالة التحديد لتعزيز الـ UI Hierarchy

    final primaryColor = const Color(0xFFB76A40);

    final backgroundColor = Colors.white;
    final borderColor = const Color(0xFFF0EAE5);
    final titleColor = const Color.fromARGB(255, 0, 0, 0);

    final iconColor = primaryColor;

    return Container(
      width: 180,

      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(24), // حواف دائرية ناعمة وعصرية
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ), // زيادة مساحة التنفس الداخلي للعناصر
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // الهيدر: الأيقونة محاطة بخلفية دائرية ناعمة
            Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(142, 210, 210, 216),
                    shape: BoxShape
                        .circle, // الدائرة تعطي مظهراً أكثر حداثة من المربع
                  ),
                  child: Icon(
                    Icons
                        .location_on_rounded, // استخدام نسخة الـ Rounded لمظهر مريح
                    size: 18,
                    color: iconColor,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  city.nameAr,
                  style: TextStyle(
                    color: titleColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    height: 1.2,
                  ),
                  maxLines: 1,
                ),
              ],
            ),
            Spacer(),
            // التوفر أو عدد العقارات المتاحة
            Center(
              child: Container(
                // margin: EdgeInsets.only(top: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFF8E4CE),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  city.availableLabelAr,
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
