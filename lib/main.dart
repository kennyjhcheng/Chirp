import 'package:bot/constants/ColorsConstants.dart';
import 'package:bot/pages/ChatBotPage.dart';
import 'package:bot/pages/PrivacyPolicyPage.dart';
import 'package:bot/pages/TermsOfService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import "package:bot/pages/WelcomeBotScreen.dart";

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Chirp',
      routes: {
        HomePageDialogflowV2.routeName: (ctx) => HomePageDialogflowV2(),
        WelcomeBotScreen.routeName: (ctx) => WelcomeBotScreen(),
        PrivacyPolicyPage.routeName: (ctx) => PrivacyPolicyPage(),
        TermsOfService.routeName: (ctx) => TermsOfService(),
      },
      theme: new ThemeData(
        fontFamily: "Poppins",
      ),
      home: new MyHomePage(title: 'Chirp'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget largeScreenRow(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20),
              padding: EdgeInsets.all(10),
              height: 250,
              width: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/ChirpBot.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          width: 50,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hey, I'm Chirp!",
              style: TextStyle(fontSize: 50, color: Color(homeScreenBlueColor)),
            ),
            SizedBox(
              height: 30,
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
                  final sp = await SharedPreferences.getInstance();

                  if (sp.getString("chirpUserName") == null) {
                    Navigator.pushNamed(context, WelcomeBotScreen.routeName);
                  } else {
                    Navigator.pushNamed(
                        context, HomePageDialogflowV2.routeName);
                  }
                },
                child: Text(
                  "Hi, Chirp!",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        )
      ],
    );
  }

  Widget smallScreenRow(context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(left: 20, bottom: 180, top: 30),
              padding: EdgeInsets.all(10),
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("img/ChirpBot.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            // SizedBox(
            //   width: 150,
            // ),
            Container(
              margin: EdgeInsets.only(bottom: 40),
              child: Text(
                "Hey, I'm Chirp!",
                style:
                    TextStyle(fontSize: 25, color: Color(homeScreenBlueColor)),
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
                          top: 15, bottom: 15, left: 30, right: 30)),
                ),
                onPressed: () async {
                  final sp = await SharedPreferences.getInstance();

                  if (sp.getString("chirpUserName") == null) {
                    Navigator.pushNamed(context, WelcomeBotScreen.routeName);
                  } else {
                    Navigator.pushNamed(
                        context, HomePageDialogflowV2.routeName);
                  }
                },
                child: Text(
                  "Hi, Chirp!",
                  style: TextStyle(fontSize: 20),
                ))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return new Scaffold(
        body: width < 700 ? smallScreenRow(context) : largeScreenRow(context));
  }
}
