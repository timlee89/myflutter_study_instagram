import 'dart:typed_data';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthMethods {
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;


  // // get user details
  // Future<List> getUserProfile({required List userProfile}) async {
  //   final user = FirebaseAuth.instance.currentUser;
  //   if (user != null) {
  //     final name = user.displayName;
  //     final email = user.email;
  //     final uid = user.uid;
  //   }
  // }

  // Signing Up User
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
  })  async {
    String result = "now";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty) {
        // registering user in auth with email and password
        await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        // await FirebaseAuth.instance.signInWithCredential(UserCredential);
        print("_signup done ");
        result = "success";
      };
    } on FirebaseAuthException catch (err) {
      if (err.code == 'weak-password') {
        result= 'The password provided is too weak.';
      } else if (err.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
    } catch (err) {
    print(err.toString());
    return err.toString();
    }
    return result;
  }

  // logging in user
  Future<String> loginUser ({
    required String email,
    required String password,
  }) async {
    String res = "Some error Occurred";
    try {
      if (email.isNotEmpty || password.isNotEmpty) {
        // logging in user with email and password
        await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        res = "success";
      } else {
        res = "Please enter all the fields";
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        res='No user found for that email.';
      } else if (e.code == 'wrong-password') {
        res='Wrong password provided for that user.';
      }
    }
    return res;
  }


  Future<void> signOut() async {
    await _auth.signOut();
  }
}


// Future<model.User> getUserDetails() async {
//   User currentUser = _auth.currentUser!;
//
//   DocumentSnapshot documentSnapshot =
//   await _firestore.collection('users').doc(currentUser.uid).get();
//
//   return model.User.fromSnap(documentSnapshot);
// }

// Future<String> signUpUser({
//   required String email,
//   required String password,
//   required String username,
//   required String bio,
//   required Uint8List file,
// }) async {
//   String res = "Some error Occurred";
//   try {
//     if (email.isNotEmpty ||
//         password.isNotEmpty ||
//         username.isNotEmpty ||
//         bio.isNotEmpty ||
//         file != null) {
//       // registering user in auth with email and password
//       UserCredential cred = await _auth.createUserWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//
//       String photoUrl =
//       await StorageMethods().uploadImageToStorage('profilePics', file, false);
//
//       model.User _user = model.User(
//         username: username,
//         uid: cred.user!.uid,
//         photoUrl: photoUrl,
//         email: email,
//         bio: bio,
//         followers: [],
//         following: [],
//       );
//
//       // adding user in our database
//       await _firestore
//           .collection("users")
//           .doc(cred.user!.uid)
//           .set(_user.toJson());
//
//       res = "success";
//     } else {
//       res = "Please enter all the fields";
//     }
//   } catch (err) {
//     return err.toString();
//   }
//   return res;
// }



// logging in user
// Future<String> loginUser({
//   required String email,
//   required String password,
// }) async {
//   String res = "Some error Occurred";
//   try {
//     if (email.isNotEmpty || password.isNotEmpty) {
//       // logging in user with email and password
//       await _auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
//       res = "success";
//     } else {
//       res = "Please enter all the fields";
//     }
//   } catch (err) {
//     return err.toString();
//   }
//   return res;
// }