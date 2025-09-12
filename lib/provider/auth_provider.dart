import 'package:flutter/material.dart';
import 'package:flutter_first_app/services/supabase/supabase.services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();

  User? user;

  AuthProvider() {
    user = _supabaseService.currentUser;
    _supabaseService.authState.listen((data) {
      user = data.session?.user;
      notifyListeners();
    });
  }

  // bool get isLoggedIn => user != null;
  bool get isLoggedIn => true;

  Future<void> login(String email, String password) async {
    await _supabaseService.signIn(email, password);
  }

  Future<void> signup(String email, String password) async {
    await _supabaseService.signUp(email, password);
  }

  Future<void> logout() async {
    await _supabaseService.signOut();
  }
}
