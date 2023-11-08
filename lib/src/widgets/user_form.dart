import 'package:flutter/material.dart';

import 'package:auth_lib/src/enums.dart';

class UserForm extends StatelessWidget {
  UserForm({
    super.key,
    required this.onSubmit,
    required this.title,
    required this.status,
    this.error,
  });
  final void Function(String email, String password) onSubmit;
  final String title;
  final UserFormStatus status;
  final String? error;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  Widget _createContentByState(UserFormStatus state) {
    switch (status) {
      case UserFormStatus.submitting:
        return const Center(child: CircularProgressIndicator());
      case UserFormStatus.success:
        return const Center(child: Text('Success'));
      default:
        return Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Email',
              ),
              controller: _emailController,
            ),
            TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
              controller: _passwordController,
            ),
            status == UserFormStatus.failure && error != null
                ? Text(
                    error!,
                    style: const TextStyle(color: Colors.red),
                  )
                : const SizedBox.shrink(),
          ],
        );
    }
  }

  void _submit(BuildContext context) {
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      return;
    }
    onSubmit(_emailController.text, _passwordController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: _createContentByState(status),
      floatingActionButton: status == UserFormStatus.submitting
          ? null
          : FloatingActionButton(
              onPressed: () => _submit(context),
              child: const Icon(Icons.check),
            ),
    );
  }
}
