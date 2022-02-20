import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gotruedart_playground/utils.dart';
import 'package:netlify_auth/netlify_auth.dart';
import 'package:url_launcher/url_launcher.dart';

class Intro extends StatelessWidget {
  final void Function(int index) moveTo;
  const Intro({
    Key? key,
    required this.moveTo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          //height: 600,
          child: RichText(
            text: TextSpan(
              children: [
                const TextSpan(
                  text: "Netlify GoTrue Dart Library",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                    height: 1.5,
                  ),
                ),
                const TextSpan(
                  text: "\n\nWelcome to the playground of Netlify's ",
                ),
                TextSpan(
                  text: "gotrue-dart library",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      launch(
                        "https://pub.dev/packages/netlify_auth#gotrue-dart-library",
                      );
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff00ad9f),
                  ),
                ),
                const TextSpan(
                  text:
                      "\nYou can test out the authentication methods with your own site. Take a peek at the ",
                ),
                TextSpan(
                  text: "source code",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // launch(
                      //   "https://pub.dev/packages/netlify_auth#gotrue-dart-library",
                      // );
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff00ad9f),
                  ),
                ),
                const TextSpan(
                  text: " or ",
                ),
                TextSpan(
                  text: "deploy a copy to Netlify",
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      // launch(
                      //   "https://pub.dev/packages/netlify_auth#gotrue-dart-library",
                      // );
                    },
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    decorationColor: Color(0xff00ad9f),
                  ),
                ),
                const TextSpan(
                  text: " to play around with the code by yourself.\n",
                ),
                const WidgetSpan(
                  child: SizedBox(
                    height: 100,
                  ),
                ),
                const TextSpan(
                  text: "Authentication methods",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                    height: 1.5,
                  ),
                ),
                const WidgetSpan(
                  child: SizedBox(
                    height: 30,
                  ),
                ),
                ...authMethods.map(
                  (authMathod) => TextSpan(children: [
                    const TextSpan(text: "\n  "),
                    TextSpan(
                      text: authMathod.title,
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          moveTo(authMethods.indexOf(authMathod));
                        },
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                        decorationColor: Color(0xff00ad9f),
                        height: 1.5,
                      ),
                    )
                  ]),
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
          "Enter your identity API Endpoint",
          style: TextStyle(
            // fontWeight: FontWeight.w600,
            fontSize: 20,
            height: 1.2,
            color: Color(0xff334147),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const IdentityApiForm()
      ],
    );
  }
}

class IdentityApiForm extends StatefulWidget {
  const IdentityApiForm({Key? key}) : super(key: key);

  @override
  _IdentityApiFormState createState() => _IdentityApiFormState();
}

class _IdentityApiFormState extends State<IdentityApiForm> {
  TextEditingController controller = TextEditingController(
    text: "https://brave-colden-1959c1.netlify.app/.netlify/identity",
  );

  void getIdentity() {
    if (controller.text.isNotEmpty) {
      AuthProvider.initConfigs(controller.text);
      log("get api identity");
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          cursorColor: const Color(0xff00ad9f),
          onEditingComplete: getIdentity,
          style: const TextStyle(
            // fontWeight: FontWeight.w600,
            fontSize: 16,
            // height: 1.2,
            // color: Color(0xff334147),
          ),
          decoration: const InputDecoration(
            labelText:
                "( Copy the endpoint on the identity page of your Netlify site dashboard )",
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
        ValueListenableBuilder<GoTrue?>(
          valueListenable: AuthProvider.auth,
          builder: (context, data, child) {
            return TextButton(
              onPressed: data == null ? getIdentity : null,
              child: Wrap(
                children: [
                  const Text(
                    "Submit",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  if (data != null) ...[
                    const SizedBox(
                      width: 15,
                    ),
                    const Icon(
                      Icons.check,
                      color: Colors.white,
                    ),
                  ],
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
            );
          },
        ),
      ],
    );
  }
}
