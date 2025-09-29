import 'package:dio/dio.dart';

class UploadService {
  final Dio _dio = Dio();

  Future<void> uploadFile({required CancelToken cancelToken, required Function(double) onProgress}) async {
    print('Upload started...');
    // 5 saniyelik bir yükleme simülasyonu
    for (int i = 1; i <= 10; i++) {
      // Her yarım saniyede bir token'ın iptal edilip edilmediğini kontrol et
      if (cancelToken.isCancelled) {
        throw DioError(
          requestOptions: RequestOptions(path: ''),
          error: 'Upload cancelled by user',
          type: DioErrorType.cancel,
        );
      }
      await Future.delayed(const Duration(milliseconds: 500));
      onProgress(i / 10.0);
    }
    print('Upload finished.');
  }
}