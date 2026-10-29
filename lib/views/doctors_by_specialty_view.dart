import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/specialty.dart';
import 'package:flutter_application_4/widgets/build_doctors_future.dart';

class DoctorsBySpecialtyView extends StatefulWidget {
  const DoctorsBySpecialtyView({super.key});

  @override
  State<DoctorsBySpecialtyView> createState() => _DoctorsBySpecialtyViewState();
}

class _DoctorsBySpecialtyViewState extends State<DoctorsBySpecialtyView> {
  late Specialty specialty;
  String? selectedCity;
  int? maxPrice;
  double? minRating;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    specialty = ModalRoute.of(context)!.settings.arguments as Specialty;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
       
          SliverAppBar(
            pinned: true,
            expandedHeight: 120,
            backgroundColor: Colors.teal,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                alignment: Alignment.center,

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.medical_services,
                      size: 60,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    Text(
                      ' قسم الـ${specialty.name}',
                      style: const TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),

          /// محتوى الصفحة
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// وصف التخصص (اختياري)
                  // ignore: unnecessary_null_comparison
                  if (specialty.description != null)
                    Text(
                      specialty.description,
                      style: TextStyle(color: Colors.grey[600]),
                    ),

                  const SizedBox(height: 12),

                  /// زر بحث أو فلترة
                  Row(
                    children: [
                      /// فلترة المدينة
                      PopupMenuButton<String>(
                        tooltip: 'المدينة',
                        onSelected: (value) {
                          setState(() {
                            selectedCity = value == 'الكل' ? null : value;
                          });
                        },
                        itemBuilder: (_) => [
                          const PopupMenuItem(
                            value: 'الكل',
                            child: Text('كل المدن'),
                          ),
                          const PopupMenuItem(
                            value: 'صنعاء',
                            child: Text('صنعاء'),
                          ),
                          const PopupMenuItem(value: 'عدن', child: Text('عدن')),
                          const PopupMenuItem(value: 'تعز', child: Text('تعز')),
                        ],
                        child: Chip(
                          label: Text(selectedCity ?? 'المدينة'),
                          avatar: const Icon(Icons.location_city, size: 18),
                        ),
                      ),

                      const SizedBox(width: 8),

                      /// فلترة تاقييم
                      PopupMenuButton<double>(
                        tooltip: 'التقييم',
                        onSelected: (value) {
                          setState(() {
                            minRating = value == 0 ? null : value;
                          });
                        },
                        itemBuilder: (_) => const [
                          PopupMenuItem(value: 0, child: Text('كل التقييمات')),
                          PopupMenuItem(value: 1, child: Text('≥ 1')),
                          PopupMenuItem(value: 2, child: Text('≥ 2')),
                          PopupMenuItem(value: 3, child: Text('≥ 3')),
                          PopupMenuItem(value: 4, child: Text('≥ 4')),
                          PopupMenuItem(value: 5, child: Text('5 فقط')),
                        ],
                        child: Chip(
                          label: Text(
                            minRating == null ? 'التقييم' : '≥ $minRating',
                          ),
                          avatar: const Icon(Icons.star, size: 18),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// قائمة الأطباء
                  BuildDoctorsFuture(
                    key: ValueKey('$selectedCity-$minRating'),
                    specialtyId: specialty.id,
                    specialityCity: selectedCity,
                    minRating: minRating,
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
