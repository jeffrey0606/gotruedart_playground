import 'package:flutter/material.dart';
import 'package:gotruedart_playground/account_recovery.dart';
import 'package:gotruedart_playground/confirm.dart';
import 'package:gotruedart_playground/current_user.dart';
import 'package:gotruedart_playground/into.dart';
import 'package:gotruedart_playground/jwt_token.dart';
import 'package:gotruedart_playground/login.dart';
import 'package:gotruedart_playground/logout.dart';
import 'package:gotruedart_playground/password_recovery.dart';
import 'package:gotruedart_playground/sign_up.dart';
import 'package:gotruedart_playground/update_user.dart';
import 'package:scroll_to_index/scroll_to_index.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late AutoScrollController controller;
  @override
  void initState() {
    controller = AutoScrollController(
      //add this for advanced viewport boundary. e.g. SafeArea
      viewportBoundaryGetter: () => Rect.fromLTRB(
        0,
        0,
        0,
        MediaQuery.of(context).padding.bottom,
      ),

      //choose vertical/horizontal
      axis: Axis.vertical,

      //this given value will bring the scroll offset to the nearest position in fixed row height case.
      //for variable row height case, you can still set the average height, it will try to get to the relatively closer offset
      //and then start searching.
      //suggestedRowHeight: 200,
    );

    children.addAll(
      [
        Intro(
          moveTo: moveTo,
        ),
        const SizedBox(
          height: 60,
        ),
        const SignUp(),
        const SizedBox(
          height: 60,
        ),
        const Confirm(),
        const SizedBox(
          height: 60,
        ),
        const Login(),
        const SizedBox(
          height: 60,
        ),
        const PasswordRecovery(),
        const SizedBox(
          height: 60,
        ),
        const AccountRecovery(),
        const SizedBox(
          height: 60,
        ),
        const CurrentUser(),
        const SizedBox(
          height: 60,
        ),
        const UpdateUser(
          email: "",
        ),
        const SizedBox(
          height: 60,
        ),
        const GetJwtToken(),
        const SizedBox(
          height: 60,
        ),
        const Logout(),
        const SizedBox(
          height: 45,
        ),
      ],
    );
    super.initState();
  }

  void moveTo(int index) {
    controller.scrollToIndex(
      index,
      preferPosition: AutoScrollPosition.begin,
    );

    setState(() {});
  }

  List<Widget> children = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LayoutBuilder(builder: (context, constraints) {
        final Size size = Size(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        double horizontalPadding = 20;

        if (size.width > 1020) {
          horizontalPadding = size.width * 0.3;
        }
        return ListView.builder(
          padding: EdgeInsets.only(
            top: 60,
            bottom: 40,
            left: horizontalPadding,
            right: horizontalPadding,
          ),
          itemBuilder: (context, index) {
            return AutoScrollTag(
              key: ValueKey(index),
              controller: controller,
              index: index,
              child: children[index],
            );
          },
          itemCount: children.length,
        );
      }),
    );
  }
}
