import 'package:firebase_auth/firebase_auth.dart';
import 'package:inventory_tracker/models/app_user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:inventory_tracker/services/firestore_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

final authProvider = StreamProvider.autoDispose<AppUser?>((ref) async* {
  final Stream<AppUser?> userStream =
  FirebaseAuth.instance.authStateChanges().map((user) {
    if (user != null) {
      return AppUser(uid: user.uid, email: user.email!);
    }
    return null;
  });

  await for (final user in userStream) {
    yield user;
  }
});

@riverpod
class UserNameNotifier extends _$UserNameNotifier {
  @override
  String build() { return ""; }

  Future<void> getName(String id) async {
    try {
      state = await FirestoreAuthService.getUserName(id);
    }catch (e) {
      print('Error fetching from Firebase: $e');
    }
  }
}