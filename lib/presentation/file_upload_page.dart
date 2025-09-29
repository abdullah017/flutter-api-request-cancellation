import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../data/services/upload_service.dart';

class FileUploadPage extends StatefulWidget {
  const FileUploadPage({super.key});
  @override
  State<FileUploadPage> createState() => _FileUploadPageState();
}

class _FileUploadPageState extends State<FileUploadPage> {
  final UploadService _uploadService = UploadService();
  CancelToken? _cancelToken;
  double _progress = 0.0;
  String _status = 'Ready to upload';

  void _startUpload() {
    _cancelToken = CancelToken();
    setState(() => _status = 'Uploading...');

    _uploadService
        .uploadFile(
          cancelToken: _cancelToken!,
          onProgress: (progress) {
            setState(() => _progress = progress);
          },
        )
        .then((_) {
          if (mounted) {
            setState(() => _status = 'Upload Complete!');
          }
        })
        .catchError((error) {
          if (CancelToken.isCancel(error)) {
            setState(() => _status = 'Upload Cancelled by User');
          } else {
            setState(() => _status = 'Upload Failed: $error');
          }
        })
        .whenComplete(() {
          setState(() => _progress = 0.0);
        });
  }

  void _cancelUpload() {
    _cancelToken?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('File Upload Cancellation')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(_status, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 20),
              LinearProgressIndicator(value: _progress),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: _startUpload,
                    child: const Text('Start Upload'),
                  ),
                  ElevatedButton(
                    onPressed: _cancelUpload,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
