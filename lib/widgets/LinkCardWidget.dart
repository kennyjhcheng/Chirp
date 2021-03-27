import 'package:bot/constants/ColorsConstants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkCardWidget extends StatefulWidget {
  LinkCardWidget({Key key, @required this.title, @required this.link})
      : super(key: key);
  final String title;
  final String link;

  @override
  _LinkCardWidgetState createState() => _LinkCardWidgetState();
}

class _LinkCardWidgetState extends State<LinkCardWidget> {
  final nonHoverTransform = Matrix4.identity()..translate(0, 0, 0);

  final hoverTransform = Matrix4.identity()..translate(0, -10, 0);

  bool _hovering = false;

  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  void _mouseEnter(bool hover) {
    setState(() {
      _hovering = hover;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await _launchInBrowser(widget.link);
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (e) => _mouseEnter(true),
        onExit: (e) => _mouseEnter(false),
        // When it exits set it back to default

        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: _hovering ? hoverTransform : nonHoverTransform,
          height: 200,
          width: 200,
          child: Card(
            elevation: 10,
            color: Color(textComposerBackground),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
