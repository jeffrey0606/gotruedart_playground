import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gotruedart_playground/utils.dart';
import 'package:netlify_auth/netlify_auth.dart';

class PasswordRecovery extends StatelessWidget {
  const PasswordRecovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "4. Request password recover email \n",
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
                    "This function sends a request to GoTrue API and triggers a password recovery email to the specified email address\n",
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
          height: 100,
          width: double.infinity,
          child: Markdown(
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            physics: NeverScrollableScrollPhysics(),
            selectable: true,
            data: """
```
auth
  .requestPasswordRecovery(email)
  .then(response => debugPrint("Recovery email sent"))
  .catchError(error => debugPrint("Error sending recovery mail"));
```
""",
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Example response object",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.5,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const SizedBox(
          height: 50,
          width: double.infinity,
          child: Markdown(
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            physics: NeverScrollableScrollPhysics(),
            selectable: true,
            data: """
```
{}
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
        const TryPasswordRecovery()
      ],
    );
  }
}

class TryPasswordRecovery extends StatefulWidget {
  const TryPasswordRecovery({Key? key}) : super(key: key);

  @override
  _TryPasswordRecoveryState createState() => _TryPasswordRecoveryState();
}

class _TryPasswordRecoveryState extends State<TryPasswordRecovery> {
  bool isLoading = false;
  bool success = false;
  String? errorMsg;

  void recover() {
    final User? user = AuthProvider.auth.value?.currentUser();
    if (user == null) {
      errorMsg = "please login required*";
      setState(() {});
      return;
    }

    errorMsg = null;
    isLoading = true;
    success = false;
    setState(() {});

    AuthProvider.auth.value?.requestPasswordRecovery(user.email ?? "").then(
      (_) {
        errorMsg = null;
        isLoading = false;
        success = true;
        setState(() {});
        debugPrint("email send with success");
      },
    ).catchError(
      (error) {
        errorMsg = "$error";
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
          onPressed: recover,
          child: Wrap(
            children: [
              const Text(
                "Request recovery email",
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
        if (errorMsg != null && !isLoading)
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
