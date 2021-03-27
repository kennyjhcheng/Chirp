import 'package:bot/constants/ColorsConstants.dart';
import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  EdgeInsets expansionChildrenPadding = EdgeInsets.all(16);
  static String routeName = "/privacypolicy";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: EdgeInsets.all(12),
          child: SingleChildScrollView(
            child: Column(
              children: [
                ListTile(
                  leading: Image.asset(
                    "img/ChirpBot.png",
                  ),
                ),
                ExpansionTile(
                  initiallyExpanded: true,
                  childrenPadding: expansionChildrenPadding,
                  title: Text(
                    "Chirp Privacy Policy",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 28,
                    ),
                  ),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "Chirp is an app created by young students, designers, and developers with the goal of helping youth. Our goals involve improving access to education and technology for people like us, therefore we are committed to being transparent and respectful of how we may use user data.",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "We are using several Google services, frameworks and APIs for Chirp which incorporate Google’s general API terms and Google’s overall privacy policy for your reference.",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "Be reassured that although Chirp may ask you for some information about you, you have the option to decline. Chirp collected information through your interactions with it without using cookies.",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ],
                ),
                ExpansionTile(
                  childrenPadding: expansionChildrenPadding,
                  title: Text(
                    "How we may use your information",
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 28),
                  ),
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "• Improving our products",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Providing assistance with our product or other inquiries",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Researching user experience",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Submission for Google’s 2021 Solutions Challenge",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Promoting Chirp’s service",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Aggregating and analyzing any information collected",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Allowing Google to collect and use data as outlined in their policies",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   "• Providing assistance with our product or other inquiries",
                    //   softWrap: true,
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(fontSize: 18),
                    // ),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    // Text(
                    //   "• Researching user experience",
                    //   softWrap: true,
                    //   textAlign: TextAlign.start,
                    //   style: TextStyle(fontSize: 18),
                    // ),
                  ],
                ),
                ExpansionTile(
                  childrenPadding: expansionChildrenPadding,
                  title: Text(
                    "How information is collected",
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 28),
                  ),
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "• Using Chirp and answering questions for demographic comprehension",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Email content and inquiries sent by you to us",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                ExpansionTile(
                  childrenPadding: expansionChildrenPadding,
                  title: Text(
                    "What information is collected",
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 28),
                  ),
                  children: [
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "• Age",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Race",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Gender Identity",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Questions asked by you to Chirp",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                ExpansionTile(
                  childrenPadding: expansionChildrenPadding,
                  title: Text(
                    "What information is not collected",
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 28),
                  ),
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.all(0),
                      title: Text(
                        "Chirp will not collect any personal information that may be used to identify the user. This information includes:",
                        softWrap: true,
                        textAlign: TextAlign.start,
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    ListView(
                      shrinkWrap: true,
                      children: [
                        Text(
                          "• Birthdate",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Name",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Address",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• IP Address",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Email",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Phone Number",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                        Text(
                          "• Access Date and Time",
                          softWrap: true,
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    )
                  ],
                ),
                ExpansionTile(
                  expandedAlignment: Alignment.centerLeft,
                  childrenPadding: expansionChildrenPadding,
                  title: Text(
                    "How to contact us",
                    softWrap: true,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 28),
                  ),
                  children: [
                    Text(
                      "If you have any concerns, feel free to contact askstudiocontact@gmail.com",
                      softWrap: true,
                      textAlign: TextAlign.start,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
