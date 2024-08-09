import 'package:bloggers_hub/core/error/server_exception.dart';
import 'package:bloggers_hub/features/auth/data/models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasources {
  Future<UserModel> signInWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
  Future<UserModel?> getCurrentUser();
}

class AuthRemoteDatasourcesImpl implements AuthRemoteDatasources {
  final SupabaseClient supabaseClient;
  @override
  Session? get session => supabaseClient.auth.currentSession;
  AuthRemoteDatasourcesImpl(this.supabaseClient);
  @override
  Future<UserModel> loginWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      if (response.user == null) {
        throw ServerException(message: 'User is null');
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: session!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signInWithEmailAndPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final response = await supabaseClient.auth
          .signUp(email: email, password: password, data: {
        'name': name,
      });
      if (response.user == null) {
        throw ServerException(message: 'User is null');
      }
      return UserModel.fromJson(response.user!.toJson())
          .copyWith(email: session!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      if (session == null) {
        return null;
      }
      final userData = await supabaseClient
          .from('profiles')
          .select()
          .eq('id', session!.user.id);
      return UserModel.fromJson(userData.first).copyWith(email: session!.user.email);
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
}
