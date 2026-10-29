import 'package:flutter/material.dart';

class LoginButton extends StatefulWidget {
  // اجعل الدالة تعيد Future<void> لكي ينتظرها الزر
  final Future<void> Function() onLogin; 
  final String text;

  const LoginButton({super.key, required this.onLogin, required this.text});

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF0F67FF),
        padding: const EdgeInsets.symmetric(vertical: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      onPressed: () async {
        if (isLoading) return;

        setState(() => isLoading = true);

        // هنا السحر: الزر سينتظر تنفيذ دالة الـ API الحقيقية
        await widget.onLogin();

        if (mounted) {
          setState(() => isLoading = false);
        }
      },
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: isLoading
            ? const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 3,
                ),
              )
            : Text(
                widget.text,
                key: const ValueKey('text'),
                style: const TextStyle(
                  fontFamily: 'almarai',
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }
}