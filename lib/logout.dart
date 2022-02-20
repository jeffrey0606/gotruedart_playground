import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gotruedart_playground/utils.dart';
import 'package:netlify_auth/netlify_auth.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "9. Log out\n",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 26,
                  height: 1.5,
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  height: 40,
                ),
              ),
              TextSpan(
                text:
                    "This function removes the jwt token of the current user from local storage and log the user out.\n",
                style: TextStyle(
                  color: Color(0xff334147),
                ),
              ),
              WidgetSpan(
                child: SizedBox(
                  height: 60,
                ),
              ),
              TextSpan(
                text: "Example usage",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                  height: 1.5,
                ),
              ),
            ],
            style: TextStyle(
              // fontWeight: FontWeight.w600,
              fontSize: 18,
              height: 1.2,
              color: Colors.black,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const SizedBox(
          height: 150,
          width: double.infinity,
          child: Markdown(
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            physics: NeverScrollableScrollPhysics(),
            selectable: true,
            data: """
```
const user = auth.currentUser();
user
  .logout()
  .then(response => debugPrint("User logged out"))
  .catchError((error){
    debugPrint("Failed to logout user");
    rethrow;
  });
```
""",
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Try it out!",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 22,
            height: 1.2,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "(Make sure you're logged in!)",
          style: TextStyle(
            color: Color(0xff334147),
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const TryLogout()
      ],
    );
  }
}

class TryLogout extends StatefulWidget {
  const TryLogout({Key? key}) : super(key: key);

  @override
  _TryLogoutState createState() => _TryLogoutState();
}

class _TryLogoutState extends State<TryLogout> {
  bool isLoading = false;
  bool success = false;
  String? errorMsg;

  void logout() {
    User? user = AuthProvider.auth.value?.currentUser();
    if (user == null) {
      errorMsg = "please login required*";

      setState(() {});
      return;
    }
    errorMsg = null;
    isLoading = true;
    success = false;
    setState(() {});

    user.logout().then(
      (response) {
        errorMsg = null;
        isLoading = false;
        success = true;
        setState(() {});
        debugPrint("Log out");
      },
    ).catchError(
      (error) {
        errorMsg = "${error.message}";
        isLoading = false;
        setState(() {});

        debugPrint("failed to sign up: $error");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: logout,
          child: Column(
            children: [
              const Text(
                "Log out!",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
              if (success && !isLoading) ...[
                const SizedBox(
                  width: 15,
                ),
                const Icon(
                  Icons.check,
                  color: Colors.white,
                ),
              ],
              if (isLoading)
                Container(
                  padding: const EdgeInsets.only(left: 5),
                  height: 22,
                  width: 27,
                  child: const CircularProgressIndicator(
                    backgroundColor: Colors.transparent,
                    color: Colors.white,
                    strokeWidth: 1.4,
                  ),
                ),
            ],
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              const Color(0xff00ad9f),
            ),
            elevation: MaterialStateProperty.all(5),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(
                horizontal: 40,
                vertical: 20,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        if (errorMsg != null)
          Text(
            errorMsg ?? "",
            style: const TextStyle(
              color: Colors.red,
              fontSize: 18,
            ),
          ),
      ],
    );
  }
}
