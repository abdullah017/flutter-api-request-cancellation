import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../data/models/album_model.dart';
import '../providers.dart';

class UserDetailPage extends ConsumerStatefulWidget {
  final int userId;
  const UserDetailPage({super.key, required this.userId});

  @override
  ConsumerState<UserDetailPage> createState() => _UserDetailPageState();
}

class _UserDetailPageState extends ConsumerState<UserDetailPage> {
  // 1. Her state için ayrı bir Client oluştur.
  final http.Client _client = http.Client();
  Future<List<Album>>? _albumsFuture;

  @override
  void initState() {
    super.initState();
    // 2. Servis metoduna client'ı parametre olarak ver.
    _albumsFuture = ref.read(userServiceProvider).getUserAlbums(widget.userId, client: _client);
  }

  @override
  void dispose() {
    // 3. Sayfa yok olduğunda, client'ı kapatarak bekleyen isteği iptal et.
    print('--- UserDetailPage DISPOSED: Closing HTTP client now. ---');
    _client.close(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User ${widget.userId} Albums')),
      body: FutureBuilder<List<Album>>(
        future: _albumsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            // İptal edildiğinde bu bloğa düşecek.
            return Center(
              child: Text(
                'Request was cancelled or failed.\nError: ${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) => ListTile(title: Text(snapshot.data![index].title)),
            );
          }
          return const Center(child: Text('No data'));
        },
      ),
    );
  }
}