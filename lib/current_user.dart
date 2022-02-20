import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gotruedart_playground/utils.dart';
import 'package:netlify_auth/netlify_auth.dart';

class CurrentUser extends StatelessWidget {
  const CurrentUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "6. Get current user \n",
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
                    "This function returns the current user object when a user is logged in.\n",
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
          height: 50,
          width: double.infinity,
          child: Markdown(
            styleSheetTheme: MarkdownStyleSheetBaseTheme.cupertino,
            physics: NeverScrollableScrollPhysics(),
            selectable: true,
            data: """
```
final user = auth.currentUser();
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
        const TryGetCurrentUser()
      ],
    );
  }
}

class TryGetCurrentUser extends StatefulWidget {
  const TryGetCurrentUser({Key? key}) : super(key: key);

  @override
  _TryGetCurrentUserState createState() => _TryGetCurrentUserState();
}

class _TryGetCurrentUserState extends State<TryGetCurrentUser> {
  User? user;
  String? errorMsg;
  void getCurrentUser() {
    user = AuthProvider.auth.value?.currentUser();
    if (user == null) {
      errorMsg = "please login required*";
    } else {
      errorMsg = null;
    }
    setState(() {});
    log("current user");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextButton(
          onPressed: getCurrentUser,
          child: const Text(
            "Get current user!",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
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
        if (user != null)
          Text(
            "User: ${user?.email}",
            style: const TextStyle(
              color: Color(0xff00ad9f),
              fontSize: 18,
            ),
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
