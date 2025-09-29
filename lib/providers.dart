import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'data/models/user_model.dart';
import 'data/services/user_service.dart';

// Servisler için provider'lar
final userServiceProvider = Provider((ref) => UserService());

// Veri için provider'lar
final usersProvider = FutureProvider<List<User>>((ref) {
  return ref.watch(userServiceProvider).getUsers();
});