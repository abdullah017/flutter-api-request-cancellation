// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_api_cancel/presentation/user_page.dart';
import 'file_upload_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('API Demos')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const UsersPage()),
              ),
              child: const Text('Scenario 1: Page Dispose Cancellation'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const FileUploadPage()),
              ),
              child: const Text('Scenario 2: Manual Cancellation'),
            ),
          ],
        ),
      ),
    );
  }
}
