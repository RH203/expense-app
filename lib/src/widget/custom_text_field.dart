import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
  });

  final String labelText, hintText;
  final TextEditingController controller;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: const TextStyle(
            color: Colors.black,
          ),
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.all(20),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: BorderSide(
              color: Colors.blue[300]!,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }
}
