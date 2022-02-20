import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gotruedart_playground/utils.dart';
import 'package:netlify_auth/netlify_auth.dart';

class UpdateUser extends StatelessWidget {
  const UpdateUser({Key? key, required this.email}) : super(key: key);
  final String email;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "7. Update user\n",
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
                    "This function updates a user object with specified attributes.\n",
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
          height: 200,
          width: double.infinity,
          child: Markdown(
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            physics: NeverScrollableScrollPhysics(),
            selectable: true,
            data: """
```
const user = auth.currentUser();

user
  .update({ email: "example@example.com", password: "password" })
  .then(user => debugPrint("Updated user"))
  .catchError((error) {
    debugPrint("Failed to update user");
    rethrow;
  );
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
        Text(
          "Your email address: $email",
          style: const TextStyle(
            color: Color(0xff334147),
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          "Are you logged in?",
          style: TextStyle(
            color: Color(0xff334147),
            fontSize: 18,
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        const TryUpdateUser()
      ],
    );
  }
}

class TryUpdateUser extends StatefulWidget {
  const TryUpdateUser({Key? key}) : super(key: key);

  @override
  _TryUpdateUserState createState() => _TryUpdateUserState();
}

class _TryUpdateUserState extends State<TryUpdateUser> {
  TextEditingController controller = TextEditingController();

  bool isLoading = false;
  bool success = false;
  String? errorMsg;

  void getUpdateUser() {
    final String password = controller.text;
    User? user = AuthProvider.auth.value?.currentUser();

    if (user == null) {
      errorMsg = "please login required*";
      setState(() {});
      return;
    }
    if (password.isEmpty) {
      errorMsg = "new password required*";
      setState(() {});
      return;
    }

    errorMsg = null;
    isLoading = true;
    success = false;
    setState(() {});

    user.update({
      "email": user.email,
      password: password,
    }).then(
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
          TextField(
            controller: controller,
            cursorColor: const Color(0xff00ad9f),
            onEditingComplete: getUpdateUser,
            style: const TextStyle(
              // fontWeight: FontWeight.w600,
              fontSize: 16,
              // height: 1.2,
              // color: Color(0xff334147),
            ),
            decoration: InputDecoration(
              labelText: "New password",
              prefixIcon: const Icon(
                Icons.api_rounded,
                color: Color(0xff00ad9f),
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
          TextButton(
            onPressed: getUpdateUser,
            child: Wrap(
              children: [
                const Text(
                  "update user!",
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
