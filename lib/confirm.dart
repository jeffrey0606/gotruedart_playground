import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:gotruedart_playground/utils.dart';
import 'package:netlify_auth/netlify_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Confirm extends StatelessWidget {
  const Confirm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 350,
          child: SelectableText.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: "2. Confirm\n",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 26,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text:
                      "\n\nThis function confirms a user sign up via a unique confirmation token.\n\nWhen a new user signed up, a confirmation email will be sent to the registered email address.\n(Make sure ",
                ),
                const TextSpan(
                  text: "Autoconfirm",
                  style: TextStyle(
                    backgroundColor: Color(0xfffafafa),
                  ),
                ),
                const TextSpan(
                  text: " isn't turned on under ",
                ),
                TextSpan(
                  text: "identity settings",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        "https://www.netlify.com/docs/identity/#adding-users",
                      );
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff00ad9f),
                  ),
                ),
                const TextSpan(
                  text: " .)",
                ),
                const TextSpan(
                  text:
                      "\n\nIn the email, there's a link that says Confirm your email address. When a user clicks on the link, it'll be redirected to the site with a ",
                ),
                TextSpan(
                  text: "fragment identifier\n",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        "https://en.wikipedia.org/wiki/Fragment_identifier",
                      );
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff00ad9f),
                  ),
                ),
                const TextSpan(
                  text: "#confirmation_token=Iyo9xHvsGVbW-9A9v4sDmQ",
                  style: TextStyle(
                    backgroundColor: Color(0xfffafafa),
                  ),
                ),
                const TextSpan(
                  text: " in the URL.",
                ),
                const WidgetSpan(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
              ],
              style: const TextStyle(
                // fontWeight: FontWeight.w600,
                fontSize: 18,
                height: 1.2,
                color: Color(0xff334147),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Example code",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.2,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
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
auth
  .confirm(confirmationLink)
  .then((response) {
    debugPrint("Confirmation email sent"));
  })
  .catchError((e) {
    debugPrint(e.toString());
  });
```
""",
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Confirm a new user signup",
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.2,
            color: Colors.black,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const ConfirmForm()
      ],
    );
  }
}

class ConfirmForm extends StatefulWidget {
  const ConfirmForm({Key? key}) : super(key: key);

  @override
  _ConfirmFormState createState() => _ConfirmFormState();
}

class _ConfirmFormState extends State<ConfirmForm> {
  TextEditingController controller = TextEditingController();

  bool isLoading = false;
  bool success = false;
  String? errorMsg;

  void confirm() {
    final String confrimationLink = controller.text;
    GoTrue? auth = AuthProvider.auth.value;

    if (auth == null) {
      errorMsg = "please identity api endpoint required*";
      setState(() {});
      return;
    }
    if (confrimationLink.isEmpty) {
      errorMsg = "confrimation Link required*";
      setState(() {});
      return;
    }

    errorMsg = null;
    isLoading = true;
    success = false;
    setState(() {});

    auth
        .confirm(
      confrimationLink,
      false,
    )
        .then(
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          cursorColor: const Color(0xff00ad9f),
          onEditingComplete: confirm,
          style: const TextStyle(
            // fontWeight: FontWeight.w600,
            fontSize: 16,
            // height: 1.2,
            // color: Color(0xff334147),
          ),
          decoration: const InputDecoration(
            labelText: "( Copy the link sent to your email and past here )",
            prefixIcon: Icon(
              Icons.api_rounded,
              color: Color(0xff00ad9f),
            ),
            labelStyle: TextStyle(
              // fontWeight: FontWeight.w600,
              fontSize: 16,
              // height: 1.2,
              color: Color(0xff334147),
            ),
            focusedBorder: UnderlineInputBorder(
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
          onPressed: confirm,
          child: Wrap(
            children: [
              const Text(
                "Confirm",
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
                horizontal: 50,
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
