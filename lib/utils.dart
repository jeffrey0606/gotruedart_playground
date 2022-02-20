import 'package:flutter/cupertino.dart';
import 'package:netlify_auth/netlify_auth.dart';

const List<AuthMethod> authMethods = [
  AuthMethod(title: "Sign up"),
  AuthMethod(title: "Confirmation"),
  AuthMethod(title: "Log in"),
  AuthMethod(title: "Request Password Recovery"),
  AuthMethod(title: "Recover"),
  AuthMethod(title: "Get current user"),
  AuthMethod(title: "Update user"),
  AuthMethod(title: "Get JWT token"),
  AuthMethod(title: "Log out"),
];

class AuthMethod {
  final String title;
  const AuthMethod({
    required this.title,
  });
}

//"https://relaxed-varahamihira-0dcacc.netlify.app/.netlify/identity"
class AuthProvider {
  static ValueNotifier<GoTrue?> auth = ValueNotifier<GoTrue?>(null);

  static void initConfigs(String apiUrl) {
    auth.value = GoTrue(
      GoTrueInit(
        APIUrl: apiUrl,
        setCookie: true,
      ),
    );
  }
}
