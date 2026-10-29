import 'package:flutter/material.dart';
import 'package:flutter_application_4/models/booking_request.dart';
import 'package:flutter_application_4/services/patient_service.dart';

class BookingRecordsPage extends StatefulWidget {
  const BookingRecordsPage({super.key});

  @override
  State<BookingRecordsPage> createState() => _BookingRecordsPageState();
}

class _BookingRecordsPageState extends State<BookingRecordsPage> {
  // تعريف المستقبل لجلب البيانات
  late Future<List<BookingRequest>> _futureRequests;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    // استخدام PatientService كما طلبت
    setState(() {
      _futureRequests = PatientService().getMyRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F9), // لون خلفية هادئ
      appBar: AppBar(
        title: const Text(
          'سجل الحجوزات',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
        elevation: 0,
      ),
      body: FutureBuilder<List<BookingRequest>>(
        future: _futureRequests,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return _buildErrorWidget(snapshot.error.toString());
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return _buildEmptyWidget();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final item = snapshot.data![index];
              return _itemCard(item);
            },
          );
        },
      ),
    );
  }

  Widget _itemCard(BookingRequest booking) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: IntrinsicHeight(
          child: Row(
            children: [
              // شريط جانبي ملون حسب الحالة
              Container(
                width: 6,
                color: booking.status == 'pending'
                    ? Colors.orange
                    : Colors.green,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "موعد: ${booking.appointmentDate}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                          _statusChip(booking.status),
                        ],
                      ),
                      const SizedBox(height: 12),
                      _infoRow(
                        Icons.phone_android,
                        "الطبيب",
                        booking.doctorPhone,
                      ),
                      const SizedBox(height: 8),
                      _infoRow(
                        Icons.access_time_rounded,
                        "التوقيت",
                        "${_formatTime(booking.startTime)} - ${_formatTime(booking.endTime)}",
                      ),
                      if (booking.reason != null) ...[
                        const Divider(height: 20),
                        Text(
                          "سبب الزيارة: ${booking.reason}",
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة بسيطة لتنسيق الوقت (بدون مكتبة خارجية)
  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return "--:--";
    // نأخذ أول 5 حروف فقط (HH:mm) من 10:30:00
    return time.substring(0, 5);
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.indigoAccent),
        const SizedBox(width: 8),
        Text(
          "$label: ",
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
        ),
      ],
    );
  }

  Widget _statusChip(String status) {
    bool isPending = status == 'pending';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPending
            ? Colors.orange.withOpacity(0.1)
            : Colors.green.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        isPending ? "قيد الانتظار" : "مكتمل",
        style: TextStyle(
          color: isPending ? Colors.orange[800] : Colors.green[800],
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildEmptyWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.folder_open_outlined, size: 70, color: Colors.grey[300]),
          const SizedBox(height: 10),
          const Text(
            "لا يوجد سجلات متاحة حالياً",
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off_rounded, size: 60, color: Colors.redAccent),
          const SizedBox(height: 10),
          const Text("خطأ في الاتصال بالسيرفر"),
          TextButton(onPressed: _loadData, child: const Text("إعادة المحاولة")),
        ],
      ),
    );
  }
}
