import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final bool isSecure;
  final Icon icon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool isNumberOnly;

  const InputField({
    super.key,

    required this.hintText,
    required this.isSecure,
    required this.icon,
    required this.controller,
    this.validator,
    required this.isNumberOnly,
    this.labelText,
  });

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField>
    with SingleTickerProviderStateMixin {
  bool showPassword = false;

  late AnimationController _shakeController;
  late Animation<double> _offsetAnimation;

  @override
  void initState() {
    super.initState();

    _shakeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 350),
    );

    _offsetAnimation = Tween<double>(
      begin: 0,
      end: 24,
    ).chain(CurveTween(curve: Curves.elasticIn)).animate(_shakeController);
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  void togglePassword() {
    setState(() => showPassword = !showPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 35, right: 15),
      child: AnimatedBuilder(
        animation: _shakeController,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(_offsetAnimation.value - 10, 0),
            child: child,
          );
        },
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isSecure ? !showPassword : false,

          validator: (value) {
            final error = widget.validator?.call(value);

            if (error != null) {
              _shakeController.forward().then((_) => _shakeController.reset());
            }

            return error;
          },

          inputFormatters: [
            if (widget.isNumberOnly) FilteringTextInputFormatter.digitsOnly,
          ],

          style: TextStyle(
            fontFamily: 'almarai',
            fontSize: 18,
            color: Colors.black,
          ),

          decoration: InputDecoration(
            hintStyle: TextStyle(fontFamily: "almarai"),
            labelStyle: TextStyle(fontFamily: "almarai"),

            errorStyle: TextStyle(
              fontFamily: "almarai",
              fontWeight: FontWeight.w700,
              fontSize: 14,
              color: Colors.red,
            ),

            labelText: widget.labelText,
            hintText: widget.hintText,
            prefixIcon: widget.icon,
            filled: true,
            fillColor: Colors.blueAccent.withOpacity(0.05),
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 18),

            border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),

            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 1.5),
            ),

            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF0F67FF), width: 2),
              borderRadius: BorderRadius.circular(12),
            ),

            suffixIcon: widget.isSecure
                ? IconButton(
                    onPressed: togglePassword,
                    icon: Icon(
                      showPassword ? Icons.visibility : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
