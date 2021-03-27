import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  static String routeName = "/termsofservice";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Terms of service"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text("Chirp Terms of service"),
            ],
          ),
        ),
      ),
    );
  }
}
