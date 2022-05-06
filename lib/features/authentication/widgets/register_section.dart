import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../shared/widgets/password_form_field.dart';
import '../../../utils/validators.dart';

class RegisterSection extends StatefulWidget {
  const RegisterSection({
    Key? key,
    required this.onRegisterPressed,
    required this.onChangeLoginPressed,
  }) : super(key: key);

  final VoidCallback onRegisterPressed, onChangeLoginPressed;

  @override
  State<RegisterSection> createState() => _RegisterSectionState();
}

class _RegisterSectionState extends State<RegisterSection> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _rePasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _theme = Theme.of(context);
    return Form(
      key: _formKey,
      child: ListView(
        children: [
          const SizedBox(height: 100),
          Text(
            "Register",
            style: _theme.textTheme.displayMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 50),
          TextFormField(
            controller: _emailController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) return "Enter email";
              if (!Validators.isEmail(value)) {
                return "Enter a valid email address";
              }

              return null;
            },
            decoration: const InputDecoration(
              labelText: "Email",
              hintText: "example@email.com",
            ),
          ),
          const SizedBox(height: 8),
          PasswordFormField(
            controller: _passwordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) return "Enter password";
              if (value.length < 8) return "Password should of atleast 8 chars";

              return null;
            },
            labelText: "Password",
          ),
          const SizedBox(height: 8),
          PasswordFormField(
            controller: _rePasswordController,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              if (value == null || value.isEmpty) return "Enter password";
              if (value.length < 8) return "Password should of atleast 8 chars";
              if (value != _passwordController.text) {
                return "Password doesn't match";
              }

              return null;
            },
            labelText: "Re-enter Password",
          ),
          const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              if (!_formKey.currentState!.validate()) return;

              widget.onRegisterPressed();
            },
            child: const Text("Register"),
          ),
          const SizedBox(height: 12),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                const TextSpan(text: "Already have an account? "),
                TextSpan(
                  text: "Login",
                  style: _theme.textTheme.bodyMedium!
                      .copyWith(color: _theme.colorScheme.primary),
                  recognizer: TapGestureRecognizer()
                    ..onTap = widget.onChangeLoginPressed,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
