import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textType;
  final String label;
  final Icon prefixIcon;
  final IconButton suffixIcon;
  final int lines;
  final String Function(String) validator;
  final Function() onTab;
  final bool visibility;

  const CustomTextField({
    Key key,
    @required this.controller,
    @required this.textType,
    @required this.prefixIcon,
    @required this.label,
    this.visibility,
    this.lines,
    this.onTab,
    this.suffixIcon,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: textType,
      maxLines: lines ?? 1,
      obscureText: visibility ?? false,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade50,
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.blue.shade800,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.green,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
            width: 1.3,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      validator: validator,
      onTap: onTab,
    );
  }
}
