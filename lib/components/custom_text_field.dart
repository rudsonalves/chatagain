import 'package:flutter/material.dart';

class CunstomTextField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final IconData? suffixIcon;
  final bool? obscureText;
  final String? Function(String?)? validator;

  const CunstomTextField({
    super.key,
    required this.label,
    required this.controller,
    this.suffixIcon,
    this.obscureText,
    required this.validator,
  });

  @override
  State<CunstomTextField> createState() => _CunstomTextFieldState();
}

class _CunstomTextFieldState extends State<CunstomTextField> {
  IconData? suffixIcon;
  late bool obscureText;

  @override
  void initState() {
    super.initState();

    obscureText = true;

    if (widget.label.toLowerCase().contains('password')) {
      suffixIcon = Icons.visibility_off;
      obscureText = true;
    } else {
      suffixIcon = widget.suffixIcon;
      obscureText = widget.obscureText ?? false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        validator: widget.validator,
        controller: widget.controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: widget.label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          suffixIcon: widget.suffixIcon != null
              ? IconButton(
                  icon: Icon(suffixIcon),
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                      suffixIcon =
                          obscureText ? Icons.visibility_off : Icons.visibility;
                    });
                  },
                )
              : null,
        ),
      ),
    );
  }
}
