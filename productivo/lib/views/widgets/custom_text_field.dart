import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool isPassword;
  final TextEditingController controller;
  final bool isError;
  final String? errorMessage;

  const CustomTextField({
    super.key,
    required this.labelText,
    this.isPassword = false,
    required this.controller,
    this.isError = false,
    this.errorMessage,
  });

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const UnderlineInputBorder(),
        errorText: widget.isError ? widget.errorMessage : null,
        errorBorder: widget.isError
            ? const UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.red))
            : null,
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
    );
  }
}
