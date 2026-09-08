import 'package:flutter/material.dart';

/// A simple error page that displays an error message.
class ErrorPage extends StatelessWidget {
  final String message;

  const ErrorPage({
    super.key,
    required this.message,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            message,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}