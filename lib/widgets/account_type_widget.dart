import 'package:flutter/material.dart';

class AccountTypeWidget extends StatelessWidget {
  final String name;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isLeftButton;

  const AccountTypeWidget({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
    required this.isLeftButton,
  });

  @override
  Widget build(BuildContext context) {
    // لا تستخدم const هنا لأن isSelected متغير
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 56,
          margin: EdgeInsets.only(
            left: isLeftButton ? 27 : 0,
            right: isLeftButton ? 0 : 27,
          ),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xFF0F67FF) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? Icons.check_circle : Icons.person_outline,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                name,
                style: const TextStyle(
                  fontFamily: 'almarai',
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
