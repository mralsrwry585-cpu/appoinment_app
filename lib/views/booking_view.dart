import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../models/booking_request.dart';
import '../services/patient_service.dart';

class BookingFormPage extends StatefulWidget {
  final Doctor doctor;
  const BookingFormPage({super.key, required this.doctor});

  @override
  State<BookingFormPage> createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final PatientService _service = PatientService();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  final TextEditingController _reasonController = TextEditingController();
  bool _loading = false;

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
    );

    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  Future<void> _submit() async {
    if (_selectedDate == null || _selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يرجى اختيار التاريخ والوقت')),
      );
      return;
    }

    setState(() => _loading = true);

    try {
      final dateTime = DateTime(
        _selectedDate!.year,
        _selectedDate!.month,
        _selectedDate!.day,
        _selectedTime!.hour,
        _selectedTime!.minute,
      );

      final startTime =
          "${_selectedTime!.hour.toString().padLeft(2, '0')}:${_selectedTime!.minute.toString().padLeft(2, '0')}";

      final BookingRequest booking = await _service.createBookingRequest(
        doctorId: widget.doctor.phone,
        doctorPhone: widget.doctor.phone,
        requestDate: dateTime,
        appointmentDate: _selectedDate!,
        startTime: startTime,
        reason: _reasonController.text.isEmpty ? null : _reasonController.text,
      );

      // عرض الرد في مربع حوار
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('تم إنشاء الحجز'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("👨‍⚕️ الطبيب: ${booking.doctorPhone}"),
              Text("👤 المريض: ${booking.patientPhone}"),
              Text("📅 التاريخ: ${booking.appointmentDate}"),
              Text("⏰ من: ${booking.startTime}"),
              Text("⏱ إلى: ${booking.endTime}"),
              Text("📌 الحالة: ${booking.status}"),
              Text("📝 السبب: ${booking.reason ?? 'لا يوجد'}"),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('تم'),
            ),
          ],
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('❌ خطأ: $e')));
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('حجز مع ${widget.doctor.fullName}')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.calendar_today),
              title: Text(
                _selectedDate == null
                    ? 'اختر التاريخ'
                    : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickDate,
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(
                _selectedTime == null
                    ? 'اختر الوقت'
                    : _selectedTime!.format(context),
              ),
              trailing: const Icon(Icons.arrow_drop_down),
              onTap: _pickTime,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(
                labelText: 'سبب الحجز (اختياري)',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 24),
            _loading
                ? const CircularProgressIndicator()
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed:
                          (_selectedDate != null && _selectedTime != null)
                          ? _submit
                          : null,
                      child: const Text('إرسال الطلب'),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
