import 'package:comunicacao_dados/routes/AppRoutesEnum.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RoutesConfigs {
  static String calculateRoute() {
    if (FirebaseAuth.instance.currentUser == null ||
        FirebaseAuth.instance.currentUser.uid == null ||
        FirebaseAuth.instance.currentUser.uid.isEmpty) {
      return AppRoutesEnum.login;
    }
    if (!FirebaseAuth.instance.currentUser.emailVerified) {
      return AppRoutesEnum.verify;
    }
    return AppRoutesEnum.home;
  }
}
