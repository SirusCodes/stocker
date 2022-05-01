import 'package:flutter/material.dart';

class PasswordFormField extends StatefulWidget {
  const PasswordFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.autovalidateMode,
    this.validator,
  }) : super(key: key);

  final TextEditingController? controller;
  final String labelText;
  final AutovalidateMode? autovalidateMode;
  final FormFieldValidator<String>? validator;

  @override
  State<PasswordFormField> createState() => _PasswordFormFieldState();
}

class _PasswordFormFieldState extends State<PasswordFormField> {
  bool _hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      autovalidateMode: widget.autovalidateMode,
      obscureText: _hidePassword,
      decoration: InputDecoration(
        labelText: widget.labelText,
        hintText: "••••••••",
        suffixIcon: IconButton(
          onPressed: () => setState(() => _hidePassword = !_hidePassword),
          icon: _hidePassword
              ? const Icon(Icons.visibility_off_rounded)
              : const Icon(Icons.visibility_rounded),
        ),
      ),
    );
  }
}
