import 'package:bot/constants/ColorsConstants.dart';
import 'package:bot/pages/PrivacyPolicyPage.dart';
import 'package:bot/pages/TermsOfService.dart';
import 'package:bot/widgets/MouseRegionSpan.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WelcomeBotScreen extends StatelessWidget {
  static String routeName = "/welcomeBotScreen";
  TextEditingController nickname = new TextEditingController();

  Future<void> handleNextButton(String name, BuildContext context) async {
    final sp = await SharedPreferences.getInstance();
    if (name == "unknown") {
      sp.setString("chirpUserName", "unknown");
    } else {
      sp.setString("chirpUserName", nickname.text);
    }

    nickname.clear();
    Navigator.pushReplacementNamed(context, "/bot");
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: height < 700 ? 0 : 20, bottom: 30, top: 30),
                // padding: EdgeInsets.all(10),
                height: width < 700 ? 150 : 250,
                width: width < 700 ? 300 : 550,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("img/hearts.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Text(
                  "What's your nickname?",
                  style: TextStyle(
                      fontSize: width < 700 ? 30 : 50,
                      color: Color(homeScreenBlueColor)),
                ),
              ),
              Container(
                width: width * 0.4,
                margin: EdgeInsets.only(bottom: 30),
                child: TextField(
                  maxLength: 12,
                  controller: nickname,
                  decoration: new InputDecoration(
                      focusColor: Color(textComposerOutline),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(textComposerOutline)),
                          borderRadius: BorderRadius.circular(20)),
                      hintText: "Choose a nickname"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 28.0),
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                          text: 'By continuing, you agree to our ',
                          children: []),
                      // MouseRegionSpan(
                      //   mouseCursor: SystemMouseCursors.click,
                      //   inlineSpan: TextSpan(
                      //     text: 'Terms of Service ',
                      //     recognizer: TapGestureRecognizer()
                      //       ..onTap = () {
                      //         Navigator.pushNamed(
                      //             context, TermsOfService.routeName);
                      //       },
                      //     style: TextStyle(
                      //         fontWeight: FontWeight.bold,
                      //         color: Colors.blueAccent),
                      //   ),
                      // ),

                      MouseRegionSpan(
                        mouseCursor: SystemMouseCursors.click,
                        inlineSpan: TextSpan(
                          text: 'Privacy policy',
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, PrivacyPolicyPage.routeName);
                            },
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueAccent),
                        ),
                      ),
                      //TextSpan(text: 'and '),
                    ],
                  ),
                  softWrap: true,
                ),
              ),
              ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50)),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Color(homeScreenBlueColor),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.only(
                            top: 25, bottom: 25, left: 50, right: 50)),
                  ),
                  onPressed: () async {
                    if (nickname.text.isEmpty) {
                      return;
                    }
                    await handleNextButton(nickname.text, context);
                  },
                  child: Text(
                    "Next",
                    style: TextStyle(fontSize: 20),
                  )),
              SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () async {
                    await handleNextButton("unknown", context);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                        color: Color(homeScreenBlueColor), fontSize: 20),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
/*  CircleAvatar(
              child: Image.asset("img/placeholder.png"),
            ),
            Text(
              "Hey I'm Chirp",
              style: TextStyle(fontSize: 28),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              "Our conversations will be anonymous and private!\nJust choose a nickname and we're good to go",
              softWrap: true,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.4,
                  child: TextField(
                    maxLength: 12,
                    controller: nickname,
                    decoration: new InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "Choose a nickname"),
                  ),
                ),
                IconButton(
                    icon: Icon(Icons.send),
                    onPressed: () async {
                      final sp = await SharedPreferences.getInstance();
                      sp.setString("chirpUserName", nickname.text);

                      nickname.clear();
                      Navigator.pushReplacementNamed(context, "/bot");
                    })
              ],
            ),
            SizedBox(
              height: 35,
            ),*/
