import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:io';

class ResumeDownloadButton extends StatelessWidget {
  const ResumeDownloadButton({Key? key}) : super(key: key);

  Future<void> _downloadResume() async {
    try {
      // Load the resume from assets
      final byteData = await rootBundle.load('assets/resume.pdf');
      
      // Get the temporary directory
      final directory = await getTemporaryDirectory();
      
      // Create a file in the temporary directory
      final file = File('${directory.path}/resume.pdf');
      
      // Write the byte data to the file
      await file.writeAsBytes(byteData.buffer.asUint8List());
      
      // Optional: You might want to use a platform-specific method 
      // to open or share the file, depending on your requirements
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Resume downloaded to ${file.path}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Download failed: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _downloadResume,
      child: const Text('Download Resume'),
    );
  }
}

// Example usage in a scaffold
class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Resume App')),
      body: Center(
        child: ResumeDownloadButton(),
      ),
    );
  }
}

// Note: Remember to add the resume file to your pubspec.yaml
// assets:
//   - assets/resume.pdf

// And add dependencies in pubspec.yaml:
// dependencies:
//   flutter:
//     sdk: flutter
//   path_provider: ^2.0.15
