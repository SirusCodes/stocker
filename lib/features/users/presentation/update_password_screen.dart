import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared/widgets/password_form_field.dart';
import '../domain/services/user_service.dart';

class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({Key? key}) : super(key: key);

  static const path = "/update-password";

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _currentPassword = TextEditingController();
  final _newPassword = TextEditingController();
  final _reEnterPassword = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
    _currentPassword.dispose();
    _newPassword.dispose();
    _reEnterPassword.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update password"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              PasswordFormField(
                controller: _currentPassword,
                labelText: "Current password",
              ),
              const SizedBox(height: 15),
              PasswordFormField(
                controller: _newPassword,
                labelText: "New password",
              ),
              const SizedBox(height: 15),
              PasswordFormField(
                validator: (value) {
                  if (value == null) return "Enter password";
                  if (value != _newPassword.text) {
                    return "Password doesn't match";
                  }

                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: _reEnterPassword,
                labelText: "Re-enter password",
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: double.maxFinite,
                child: Consumer(
                  builder: (context, ref, child) => ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) return;

                      //* Add error handling
                      await ref.read(userService).updatePassword(
                            newPassword: _newPassword.text,
                            oldPassword: _currentPassword.text,
                          );
                    },
                    child: const Text("Change password"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
