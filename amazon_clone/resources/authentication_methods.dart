import 'package:amazon_clone/model/user_details_model.dart';
import 'package:amazon_clone/screens/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future<String> signUpUser(
      {required String name,
      required String address,
      required String email,
      required String password}) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (name != "" && email != "" && address != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);
        UserDetailsModel user = UserDetailsModel(name: name, address: address);
        //await cloudFirestore.uploadNameAndAddressToDatabase(user: user);
        output = "success";
      } catch (e) {
        output = e.toString();
      }
      //functions
    } else {
      output = "Please fill up everything";
    }
    return output;
  }
}
