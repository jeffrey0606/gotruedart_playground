import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class AccountRecovery extends StatelessWidget {
  const AccountRecovery({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "5. Recover a user account\n",
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
                    "This function recovers a user account via a recovery token.\n",
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
  .recover(recoveryLink)
  .then(response =>
    debugPrint("Logged in as %s")
  )
  .catchError(error => debugPrint("Failed to verify recovery token"));
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
      ],
    );
  }
}
