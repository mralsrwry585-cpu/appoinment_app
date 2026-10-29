import 'package:flutter/material.dart';
//import 'package:flutter_application_4/views/doctors_by_specialty_view.dart';
import 'package:flutter_application_4/widgets/specialty_card.dart';
import '../models/specialty.dart';
import '../services/specialty_service.dart';

class SpecialtiesSection extends StatelessWidget {
  const SpecialtiesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Specialty>>(
      future: SpecialtyService().getSpecialties(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('لا توجد تخصصات'));
        }

        final specialties = snapshot.data!;

        return Wrap(
          spacing: 15,
          runSpacing: 15,
          children: specialties.map((specialty) {
            return SpecialtyCard(
              specialty: specialty,
              onTap: () {
                print('hiiiiiiiiii');
                Navigator.pushNamed(
                  context,
                  '/dr_speciality',
                  arguments: specialty,
                );
              },
            );
          }).toList(),
        );
      },
    );
  }
}
