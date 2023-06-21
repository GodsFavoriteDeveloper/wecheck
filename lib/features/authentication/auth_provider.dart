import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wecheck/features/authentication/auth_repository.dart';

class AuthProvider with ChangeNotifier {
  User? user = FirebaseAuth.instance.currentUser;

  Future<UserCredential> login(
      {required String email, required String password}) {
    return AuthRepository().loginRepository(
      email: email,
      password: password,
    );
  }

  Future<UserCredential> registerUser({
    required String email,
    required String password,
    required String fullName,
  }) {
    return AuthRepository().registerRepository(
      email: email,
      password: password,
      fullName: fullName,
    );
  }

  Future<UserCredential> createUserWithEmailAndPasswordProvider({
    required String email,
    required String password,
  }) {
    return AuthRepository().createUserWithEmailAndPasswordRepository(
      email: email,
      password: password,
    );
  }

  Future<void> addRegisteredUserToFirestoreByGuid({
    required String userUid,
    required String email,
    required String fullName,
    required String phoneNumber,
  }) {
    return AuthRepository().addRegisteredUserToFirestoreByGuidRepository(
      userUid: userUid,
      email: email,
      fullName: fullName,
    );
  }

  Future<void> logOut() {
    return AuthRepository().logOutRepository();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfile() {
    return AuthRepository().getUserProfileRepository(
      uid: user!.uid,
    );
  }

  // Consultations

  Future<QuerySnapshot<Map<String, dynamic>>> getUserConsultationHistory() {
    return AuthRepository().getUserConsultationHistoryRepository(
      uid: user!.uid,
    );
  }

  // Dependants

  Future<QuerySnapshot<Map<String, dynamic>>> getUserDependants() {
    return AuthRepository().getUserDependantsRepository(
      uid: user!.uid,
    );
  }

  Future<DocumentReference<Map<String, dynamic>>> addDependant({
    required String name,
    required String surname,
    required String idNumber,
  }) {
    return AuthRepository().addDependantRepository(
      uid: user!.uid,
      name: name,
      surname: surname,
      idNumber: idNumber,
    );
  }

  // Allergies
  Future<QuerySnapshot<Map<String, dynamic>>> getUserAllergies() {
    return AuthRepository().getUserAllergiesRepository(
      uid: user!.uid,
    );
  }

  Future<DocumentReference<Map<String, dynamic>>> addAllergy({
    required String name,
  }) {
    return AuthRepository().addAllergyRepository(
      uid: user!.uid,
      name: name,
    );
  }

  // Chronic Conditions
  Future<QuerySnapshot<Map<String, dynamic>>> getUserChronicConditions() {
    return AuthRepository().getUserChronicConditionsRepository(
      uid: user!.uid,
    );
  }

  Future<DocumentReference<Map<String, dynamic>>> addChronicCondition({
    required String name,
  }) {
    return AuthRepository().addChronicConditionRepository(
      uid: user!.uid,
      name: name,
    );
  }
}
