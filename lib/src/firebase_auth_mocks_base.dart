import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:mockito/mockito.dart';

import 'mock_user_credential.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  final stateChangedStreamController = StreamController<User>();
  User _currentUser;

  MockFirebaseAuth({signedIn = false}) {
    if (signedIn) {
      signInWithCredential(null);
    }
  }

  @override
  User get currentUser {
    return _currentUser;
  }

  @override
  Future<UserCredential> signInWithCredential(AuthCredential credential) {
    return _fakeSignIn();
  }

  @override
  Future<UserCredential> signInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) {
    return _fakeSignIn();
  }

  @override
  Future<UserCredential> signInWithEmailAndLink({String email, String link}) {
    return _fakeSignIn();
  }

  @override
  Future<UserCredential> signInWithCustomToken(String token) async {
    return _fakeSignIn();
  }

  @override
  Future<UserCredential> signInAnonymously() {
    return _fakeSignIn();
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    stateChangedStreamController.add(null);
  }

  Future<UserCredential> _fakeSignIn() {
    final UserCredential = MockUserCredential();
    _currentUser = UserCredential.user;
    stateChangedStreamController.add(_currentUser);
    return Future.value(UserCredential);
  }

  @override
  Stream<User> get onAuthStateChanged =>
      stateChangedStreamController.stream;
}
