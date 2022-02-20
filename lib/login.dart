import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gotruedart_playground/utils.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "3. Log in\n",
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
                    "Handles user login via the specified email and password\n",
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
                text: "Example code",
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
  .login(email.value, password.value)
  .then(response => showMessage("Success! Response: " , form))
  .catchError(error => showMessage("Failed"));
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
          height: 500,
          width: double.infinity,
          child: Markdown(
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            physics: NeverScrollableScrollPhysics(),
            selectable: true,
            data: """
```
User(
    api: {
      "apiURL": "https://example.netlify.com/.netlify/identity",
      "_sameOrigin": true,
      "defaultHeaders": {}
    },
    url: "https://example.netlify.com/.netlify/identity",
    toke: Token(
      access_token: "example-jwt-token",
      token_type: "bearer",
      expires_in: 3600,
      refresh_token: "example-refresh_token",
      expires_at: 1526062471000
    ),
    id: "example-id",
    aud: "",
    role: "",
    email: "example@netlify.com",
    confirmed_at: "2018-05-04T23:57:17Z",
    app_metadata: {
      "provider": "email"
    },
    user_metadata: {},
    created_at: "2018-05-04T23:57:17Z",
    updated_at: "2018-05-04T23:57:17Z"
  
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
        const TryLoginForm()
      ],
    );
  }
}

class LoginForm {
  final TextEditingController controller;
  final String title;
  final IconData icon;
  const LoginForm(
    this.controller,
    this.title,
    this.icon,
  );
}

class TryLoginForm extends StatefulWidget {
  const TryLoginForm({Key? key}) : super(key: key);

  @override
  _TryLoginFormState createState() => _TryLoginFormState();
}

class _TryLoginFormState extends State<TryLoginForm> {
  List<LoginForm> controllers = [
    LoginForm(TextEditingController(text: "darrelntangu@gmail.com"), "Email",
        Icons.email_rounded),
    LoginForm(TextEditingController(text: "123456789"), "Password",
        Icons.lock_rounded),
  ];

  bool isLoading = false;
  bool success = false;
  String? errorMsg;

  void login() {
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

    AuthProvider.auth.value?.login(email, password).then(
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
                    onEditingComplete: login,
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
                      labelStyle: const TextStyle(
                        // fontWeight: FontWeight.w600,
                        fontSize: 16,
                        // height: 1.2,
                        color: Color(0xff334147),
                      ),
                      errorText: errorMsg,
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
            onPressed: login,
            child: Wrap(
              children: [
                const Text(
                  "Log in",
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
