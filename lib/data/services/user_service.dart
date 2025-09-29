import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/album_model.dart';
import '../models/user_model.dart';

class UserService {
  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => User.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }

  // ÖNEMLİ: Bu metot iptal edilebilir olması için bir http.Client alacak.
  Future<List<Album>> getUserAlbums(int userId, {required http.Client client}) async {
    print('Fetching albums for user $userId...');
    // İsteği kasıtlı olarak yavaşlatıyoruz ki iptal etme senaryosunu görebilelim
    await Future.delayed(const Duration(seconds: 3));

    final response = await client.get(Uri.parse('https://jsonplaceholder.typicode.com/users/$userId/albums'));
    
    if (response.statusCode == 200) {
      print('Albums fetched successfully for user $userId.');
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Album.fromJson(json)).toList();
    } else {
      print('Failed to load albums for user $userId.');
      throw Exception('Failed to load albums');
    }
  }
}