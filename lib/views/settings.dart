import 'package:flutter/material.dart';
// تأكد من استيراد كلاس الموديل الخاص بك
// import 'package:flutter_application_4/models/patient.dart';

class SettingsPage extends StatelessWidget {
  // استقبال كائن المريض من الصفحة السابقة
  final dynamic patient;

  const SettingsPage({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontFamily: 'almarai',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: patient == null
          ? const Center(child: Text("لا توجد بيانات للمستخدم"))
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // الكارد العلوي مع البيانات الحقيقية من كائن patient
                  _buildProfileCard(patient),

                  const SizedBox(height: 30),
                  _sectionTitle("الحساب"),
                  _buildSettingsGroup([
                    _settingsTile(
                      Icons.person_outline,
                      "تعديل الملف الشخصي",
                      Colors.blue,
                    ),
                    _settingsTile(
                      Icons.notifications_none_rounded,
                      "التنبيهات",
                      Colors.orange,
                    ),
                    _settingsTile(
                      Icons.lock_outline_rounded,
                      "الخصوصية والأمان",
                      Colors.green,
                    ),
                  ]),

                  const SizedBox(height: 25),
                  _sectionTitle("النظام"),
                  _buildSettingsGroup([
                    _settingsTile(
                      Icons.language_rounded,
                      "اللغة",
                      Colors.purple,
                      trailing: "العربية",
                    ),
                    _settingsTile(
                      Icons.dark_mode_outlined,
                      "الوضع الليلي",
                      Colors.blueGrey,
                      isSwitch: true,
                    ),
                  ]),

                  const SizedBox(height: 25),
                  _sectionTitle("الدعم"),
                  _buildSettingsGroup([
                    _settingsTile(
                      Icons.help_outline_rounded,
                      "مركز المساعدة",
                      Colors.teal,
                    ),
                    _settingsTile(
                      Icons.info_outline_rounded,
                      "عن التطبيق",
                      Colors.indigo,
                    ),
                  ]),

                  const SizedBox(height: 35),
                  _buildLogoutButton(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
    );
  }

  Widget _buildProfileCard(dynamic patient) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF0D00FF), Color(0xFF4B41FF)],
        ),
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 35,
            backgroundColor: Colors.white24,
            backgroundImage: patient.profileImage != null
                ? AssetImage(patient.profileImage.toString())
                : null,
            child: patient.profileImage == null
                ? const Icon(Icons.person, size: 40, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  patient.fullName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'almarai',
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  patient.phone,
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                Text(
                  patient.email,
                  style: const TextStyle(color: Colors.white60, fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(right: 10, bottom: 10),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: Colors.grey,
          fontFamily: 'almarai',
        ),
      ),
    );
  }

  Widget _buildSettingsGroup(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _settingsTile(
    IconData icon,
    String title,
    Color color, {
    String? trailing,
    bool isSwitch = false,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
      ),
      trailing: isSwitch
          ? Switch(
              value: false,
              onChanged: (v) {},
              activeColor: const Color(0xFF0D00FF),
            )
          : (trailing != null
                ? Text(trailing, style: const TextStyle(color: Colors.grey))
                : const Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                    color: Colors.grey,
                  )),
    );
  }

  Widget _buildLogoutButton() {
    return SizedBox(
      width: double.infinity,
      child: TextButton.icon(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 15),
          backgroundColor: Colors.red.withOpacity(0.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        onPressed: () {
          //logout
        },
        icon: const Icon(Icons.logout_rounded, color: Colors.red),
        label: const Text(
          "تسجيل الخروج",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            fontFamily: 'almarai',
          ),
        ),
      ),
    );
  }
}
