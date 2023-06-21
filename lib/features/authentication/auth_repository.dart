import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthRepository {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<UserCredential> loginRepository({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future<UserCredential> registerRepository({
    required String email,
    required String password,
    required String fullName,
  }) async {
    try {
      UserCredential user = await createUserWithEmailAndPasswordRepository(
        email: email,
        password: password,
      );
      await addRegisteredUserToFirestoreByGuidRepository(
        userUid: user.user!.uid,
        email: email,
        fullName: fullName,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future<UserCredential> createUserWithEmailAndPasswordRepository({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential user =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return user;
    } on FirebaseAuthException catch (e) {
      throw e.message.toString();
    }
  }

  Future<void> addRegisteredUserToFirestoreByGuidRepository({
    required String userUid,
    required String email,
    required String fullName,
  }) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userUid).set(
        {
          'email': email,
          'fullName': fullName,
        },
      );
    } catch (e) {
      print(e);
      throw e.toString();
    }
  }

  Future<void> logOutRepository() {
    return FirebaseAuth.instance.signOut();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUserProfileRepository({
    required String uid,
  }) {
    try {
      return FirebaseFirestore.instance.collection("users").doc(uid).get();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getUserConsultationHistoryRepository({
    required String uid,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("consultation-history")
          .get();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserDependantsRepository({
    required String uid,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("dependants")
          .get();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> addDependantRepository({
    required String uid,
    required String name,
    required String surname,
    required String idNumber,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("dependants")
          .add({
        "name": name,
        "surname": surname,
        "idNumber": idNumber,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getUserAllergiesRepository({
    required String uid,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("allergies")
          .get();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DocumentReference<Map<String, dynamic>>> addAllergyRepository({
    required String uid,
    required String name,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("allergies")
          .add({
        "name": name,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>>
      getUserChronicConditionsRepository({
    required String uid,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("chronic-conditions")
          .get();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<DocumentReference<Map<String, dynamic>>>
      addChronicConditionRepository({
    required String uid,
    required String name,
  }) {
    try {
      return FirebaseFirestore.instance
          .collection("users")
          .doc(uid)
          .collection("chronic-conditions")
          .add({
        "name": name,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> uploadDocumentAsBase64({
    required String data,
  }) {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      return FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        "data": data,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> uploadProfileImageAsBase64({
    required String data,
  }) {
    try {
      User user = FirebaseAuth.instance.currentUser!;
      return FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .update({
        "profile_image": data,
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> uploadProfileImageToFirebase(
      {required String data, isProfileImage = false,}) async {
        if (isProfileImage) {

        }
    return uploadDocumentAsBase64(data: data);
    // User user = FirebaseAuth.instance.currentUser!;

    // // Create a storage reference from our app
    // final storageRef = FirebaseStorage.instance.ref();

    // // Create a reference to "mountains.jpg"
    // final profilePictureRef = storageRef.child("${user.uid}.jpg");

    // // Create a reference to 'images/mountains.jpg'
    // final profileImagesRef = storageRef.child("images/${user.uid}.jpg");
    // print(user.uid);

    // // While the file names are the same, the references point to different files
    // assert(profilePictureRef.name == profileImagesRef.name);
    // assert(profilePictureRef.fullPath != profileImagesRef.fullPath);
    // String dataUrl = data;

    // try {
    //   await profilePictureRef.putString(dataUrl,
    //       format: PutStringFormat.base64Url);
    //   String imageUrl = await profilePictureRef.getDownloadURL();
    //   print(imageUrl);
    //   user.updatePhotoURL(imageUrl);
    //   return imageUrl;
    // } on FirebaseException catch (e) {
    //   throw e;
    //   // ...
    // }
  }
}
