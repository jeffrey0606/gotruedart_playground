import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gotruedart_playground/utils.dart';

class SignUp extends StatelessWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "1. Sign up\n",
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
                    "Create a new user with the specified email and password\n",
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
```dart
auth
  .signup(email, password)
  .then(response => debugPrint("Confirmation email sent"))
  .catchError(error => debugPrint("It's an error"));
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
          height: 200,
          width: double.infinity,
          child: Markdown(
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            physics: NeverScrollableScrollPhysics(),
            selectable: true,
            data: """
```
User (
  id: 'example-id',
  aud: ' ',
  role: ' ',
  email: 'example@example.com',
  confirmation_sent_at: '2018-04-27T22:36:59.636416916Z',
  app_metadata: { provider: 'email' },
  user_metadata: null,
  created_at: '2018-04-27T22:36:59.632133283Z',
  updated_at: '2018-04-27T22:37:00.061039863Z'
)
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
          height: 10,
        ),
        const TrySignupForm()
      ],
    );
  }
}

class SignupForm {
  final TextEditingController controller;
  final String title;
  final IconData icon;
  const SignupForm(
    this.controller,
    this.title,
    this.icon,
  );
}

class TrySignupForm extends StatefulWidget {
  const TrySignupForm({Key? key}) : super(key: key);

  @override
  _TrySignupFormState createState() => _TrySignupFormState();
}

class _TrySignupFormState extends State<TrySignupForm> {
  List<SignupForm> controllers = [
    SignupForm(TextEditingController(text: "darrelntangu@gmail.com"), "Email",
        Icons.email_rounded),
    SignupForm(TextEditingController(text: "123456789"), "Password",
        Icons.lock_rounded),
  ];

  bool isLoading = false;
  bool success = false;
  String? errorMsg;

  void signup() {
    final String email = controllers[0].controller.text;
    final String password = controllers[1].controller.text;
    if (email.isEmpty) {
      errorMsg = "email required*";
      setState(() {});
      return;
    }
    if (password.isEmpty) {
      errorMsg = "password required*";
      setState(() {});
      return;
    }

    errorMsg = null;
    isLoading = true;
    success = false;
    setState(() {});

    AuthProvider.auth.value?.signup(email, password).then(
      (response) {
        errorMsg = null;
        isLoading = false;
        success = true;
        setState(() {});
        debugPrint("Confirmation email sent: $response");
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

  void clear() {}

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...controllers.map(
            (input) {
              return Column(
                children: [
                  TextField(
                    controller: input.controller,
                    cursorColor: const Color(0xff00ad9f),
                    onEditingComplete: signup,
                    style: const TextStyle(
                      // fontWeight: FontWeight.w600,
                      fontSize: 16,
                      // height: 1.2,
                      // color: Color(0xff334147),
                    ),
                    decoration: InputDecoration(
                      labelText: input.title,
                      prefixIcon: Icon(
                        input.icon,
                        color: const Color(0xff00ad9f),
                      ),
                      errorText: errorMsg,
                      labelStyle: const TextStyle(
                        // fontWeight: FontWeight.w600,
                        fontSize: 16,
                        // height: 1.2,
                        color: Color(0xff334147),
                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xff00ad9f),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              );
            },
          ),
          const SizedBox(
            height: 10,
          ),
          TextButton(
            onPressed: signup,
            child: Wrap(
              children: [
                const Text(
                  "Sign me up!",
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
        ],
      ),
    );
  }
}
