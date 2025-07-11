import 'package:firebase_auth/firebase_auth.dart';
// 1. Importe as suas exceções customizadas
import 'package:netflix_clone/app/core/exceptions/auth_exceptions.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;
  AuthService({FirebaseAuth? firebaseAuth})
    : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    // 2. Envolvemos a chamada num bloco try-catch
    try {
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // 3. Traduzimos os erros do Firebase para as nossas exceções
      if (e.code == 'user-not-found' || e.code == 'invalid-credential') {
        throw UserNotFoundException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        throw GenericAuthException(
          e.message ?? 'Ocorreu um erro desconhecido.',
        );
      }
    }
  }

  Future<UserCredential> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyInUseException();
      } else {
        throw GenericAuthException(
          e.message ?? 'Ocorreu um erro desconhecido.',
        );
      }
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw GenericAuthException('Erro ao terminar a sessão.');
    }
  }

  Future<List<String>> checkEmailSignInMethods({required String email}) async {
    try {
      return await _firebaseAuth.fetchSignInMethodsForEmail(email);
    } on FirebaseAuthException catch (e) {
      throw GenericAuthException(e.message ?? 'Erro ao verificar o email.');
    }
  }
}
