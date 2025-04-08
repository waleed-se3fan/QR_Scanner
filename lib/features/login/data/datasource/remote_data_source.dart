import 'package:supabase_flutter/supabase_flutter.dart';

abstract class LoginRemoteDataSource {
  Future login(String username, String password);
}

class LoginRemoteDataSourceImpl implements LoginRemoteDataSource {
  @override
  Future login(String email, String password) async {
    try {
      var supabaseInstance = Supabase.instance.client;
      await supabaseInstance.auth
          .signInWithPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Login failed: $e');
    }
  }
}
