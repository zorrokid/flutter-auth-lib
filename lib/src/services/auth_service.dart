import 'package:firebase_auth/firebase_auth.dart';

class AuthFailure implements Exception {
  const AuthFailure({
    required this.message,
  });

  final String message;

  AuthFailure.fromCode(String code) : message = _createErrorMessage(code);

  static String _createErrorMessage(String code) {
    switch (code) {
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'wrong-password':
        return 'The password is incorrect.';
      case 'user-not-found':
        return 'The account does not exist for that email.';
      default:
        return 'An unknown error occurred.';
    }
  }
}

class AuthenticationService {
  Future<UserCredential> registerUser({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw AuthFailure.fromCode(e.code);
    } on Exception catch (_) {
      throw const AuthFailure(
        message: 'An unknown error occurred.',
      );
    }
  }

  Future<User> logInUser({
    required String email,
    required String password,
  }) async {
    try {
      print("Logging in user with email: $email");
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print("Got user credential");
      return userCredential.user!;
    } on FirebaseAuthException catch (e) {
      throw AuthFailure.fromCode(e.code);
    } on Exception catch (error) {
      print("Error: $error");
      throw const AuthFailure(
        message: 'An unknown error occurred.',
      );
    }
  }

  bool isUserLoggedIn() {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }

  Future<void> logOutUser() async => await FirebaseAuth.instance.signOut();

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AuthFailure.fromCode(e.code);
    } on Exception catch (_) {
      throw const AuthFailure(
        message: 'An unknown error occurred.',
      );
    }
  }
}
