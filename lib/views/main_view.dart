import 'package:flutter/material.dart';
//import 'package:flutter_application_4/Screens/login.dart';
//import 'package:flutter_application_4/main.dart';
// import 'package:flutter_application_4/models/appointment_type.dart';
import 'package:flutter_application_4/models/patient.dart';
// import 'package:flutter_application_4/models/specialty.dart';
import 'package:flutter_application_4/services/auth_service.dart';
import 'package:flutter_application_4/views/login_view.dart';
//import 'package:flutter_application_4/services/patient_service.dart';
//import 'package:flutter_application_4/services/auth_service.dart';
//import 'package:flutter_application_4/services/dio_client.dart';
import 'package:flutter_application_4/widgets/build_doctors_future.dart';
//import 'package:flutter_application_4/widgets/doctor_card_widget.dart';
import 'package:flutter_application_4/widgets/specialties_section.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MainView extends StatefulWidget {
  final Patient? initialPatient;
  const MainView({super.key, this.initialPatient});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final searchController = TextEditingController();
  final AuthService _patientService = AuthService();

  Patient? patient; 
  bool _isLoadingPatient = false;

  Future<void> _loadPatient() async {
    if (patient != null) return; 
    setState(() => _isLoadingPatient = true);
    try {
      patient = await _patientService.fetchPatient();
    } catch (e) {
      print("Error fetching patient: $e");
    } finally {
      setState(() => _isLoadingPatient = false);
    }
  }

  @override
  void initState() {
    super.initState();
    patient = widget.initialPatient;
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double barHeight = screenHeight * 0.23;
    final double paddingHorizontal = 27;

    return Scaffold(
      onEndDrawerChanged: (isOpened) {
        if (isOpened) {
          _loadPatient();
        }
      },
      endDrawer: Drawer(
        child: SafeArea(
          child: _isLoadingPatient
              ? Center(child: CircularProgressIndicator())
              : patient == null
              ? Center(child: Text('فشل تحميل البيانات'))
              : Column(
                  children: [
                    const SizedBox(height: 30),

                    /// صورة الحساب
                    CircleAvatar(
                      radius: 48,
                      backgroundImage: (patient?.profileImage != null &&
                              patient!.profileImage!.startsWith('http'))
                          ? NetworkImage(patient!.profileImage!)
                          : AssetImage(patient?.profileImage ?? 'assets/images/logo.png')
                              as ImageProvider,
                    ),
                    const SizedBox(height: 12),

                    /// الاسم
                    Text(
                      patient!.fullName,
                      style: TextStyle(
                        fontFamily: 'almarai',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    /// الايميل
                    Text(
                      patient!.email,
                      style: TextStyle(
                        fontFamily: 'almarai',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 2),

                    /// الهاتف
                    Text(
                      patient!.phone,
                      style: TextStyle(
                        fontFamily: 'almarai',
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 20),
                    Divider(),

                    /// عناصر القائمة
                    ListTile(
                      leading: Icon(Icons.person_outline),
                      title: Text('الملف الشخصي'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.settings_outlined),
                      title: Text('الإعدادات'),
                      onTap: () {},
                    ),
                    ListTile(
                      leading: Icon(Icons.help_outline),
                      title: Text('المساعدة'),
                      onTap: () {},
                    ),

                    Spacer(),

                    /// تسجيل الخروج
                    ListTile(
                      leading: Icon(Icons.logout, color: Colors.red),
                      title: Text(
                        'تسجيل الخروج',
                        style: TextStyle(color: Colors.red),
                      ),
                      onTap: () async {
                        await FlutterSecureStorage().delete(
                          key: 'access_token',
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (_) => LoginView()),
                          (route) => false,
                        );
                      },
                    ),

                    const SizedBox(height: 12),
                  ],
                ),
        ),
      ),

      body: Stack(
        children: [
          /// التمرير
          Padding(
            padding: EdgeInsets.only(top: barHeight), // حتى يكون أسفل الترويسة
            child: ListView(
              children: [
                // the departments (يبدأ التمرير من هنا)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: paddingHorizontal),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 18),
                      Text(
                        'التخصصات',
                        style: TextStyle(
                          fontFamily: 'almarai',
                          fontSize: 26,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20),
                      const SpecialtiesSection(),

                      SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الأطباء المميزون',
                            style: TextStyle(
                              fontFamily: 'almarai',
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          Text(
                            'عرض الكل',
                            style: TextStyle(
                              fontFamily: 'almarai',
                              fontSize: 18,
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.w800,
                              color: Colors.blue,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                //doctors cards
                BuildDoctorsFuture(),
              ],
            ),
          ),

          /// الهيدر ثابت
          Container(
            height: barHeight,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0D00FF), Color(0xFF4B41FF)],
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'مرحباً بك',
                        style: TextStyle(
                          fontFamily: 'almarai',
                          fontSize: 16,
                          color: Colors.white60,
                        ),
                      ),
                      Builder(
                        builder: (context) => Row(
                          children: [
                            // الإشعارات
                            CircleAvatar(
                              backgroundColor: Colors.blueAccent.withOpacity(
                                0.5,
                              ),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(width: 10),

                            // صورة الحساب (تفتح الدراور)
                            GestureDetector(
                              onTap: () {
                                Scaffold.of(context).openEndDrawer();
                              },
                              child: CircleAvatar(
                                radius: 18,
                                backgroundImage: (patient?.profileImage != null &&
                                        patient!.profileImage!.startsWith('http'))
                                    ? NetworkImage(patient!.profileImage!)
                                    : AssetImage(
                                        patient?.profileImage ?? 'assets/images/logo.png',
                                      ) as ImageProvider,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Text(
                    patient!.fullName,
                    style: TextStyle(
                      fontFamily: 'almarai',
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 16),

                  /// مربع البحث
                  Container(
                    height: 55,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(11),
                    ),
                    child: TextField(
                      style: TextStyle(
                        fontFamily: 'almarai',
                        fontSize: 22,
                        color: const Color.fromARGB(255, 0, 0, 0),
                      ),
                      decoration: InputDecoration(
                        hintText: 'ابحث عن طبيب او تخصص',
                        hintStyle: TextStyle(
                          fontFamily: 'almarai',
                          fontSize: 18,
                          color: Colors.black87,
                        ),
                        prefixIcon: Icon(Icons.search, color: Colors.blueGrey),
                        border: InputBorder.none,
                      ),
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
