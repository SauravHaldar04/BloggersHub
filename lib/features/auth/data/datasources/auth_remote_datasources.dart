import 'package:bloggers_hub/core/error/server_exception.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class AuthRemoteDatasources {
  Future<String> signInWithEmailAndPassword({
    required String name,
    required String email,
    required String password,
  });
  Future<String> loginWithEmailAndPassword({
    required String email,
    required String password,
  });
}

class AuthRemoteDatasourcesImpl implements AuthRemoteDatasources {
  final SupabaseClient supabaseClient;
  AuthRemoteDatasourcesImpl(this.supabaseClient);
  @override
  Future<String> loginWithEmailAndPassword({required String email, required String password}) {
    // TODO: implement loginWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<String> signInWithEmailAndPassword({required String name, required String email, required String password})async {
    try{
      final response = await supabaseClient.auth.signUp(email: email, password: password,data:{
        'name':name,
      });
     if(response.user==null){
        throw ServerException(message: 'User is null');
     }
     return response.user!.id;
    }
    catch(e){
      throw ServerException(message: e.toString());
    }
  }

}
