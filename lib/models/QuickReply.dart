import 'package:bot/models/LinkCard.dart';

class QuickReply {
  List<String> suggestions = [];
  List<String> functions = [];
  List<String> display = [];
  List<LinkCard> card = [];
  Map<String, String> onClick = {};
  Map<String, String> displayMap = {};
  String afterCardTitle = "";
  int rows = 1;
  QuickReply(List<dynamic> messages) {
    messages.forEach((message) {
      if (message['payload'] != null &&
          message['payload']['suggestions'] != null) {
        try {
          // print(message['payload']['suggestions']);
          List<dynamic> suggestionList = message['payload']['suggestions'];
          List<dynamic> functionList = message['payload']['func'];
          List<dynamic> displayList = message['payload']['display'];
          suggestionList.forEach((suggestion) => suggestions.add(suggestion));
          functionList.forEach((func) => functions.add(func));
          displayList.forEach((disp) => display.add(disp));
          for (int i = 0; i < suggestions.length; i++) {
            onClick[suggestions[i]] = functions[i];
            displayMap[suggestions[i]] = display[i];
          }
          if (message['payload']['card'] != null) {
            List<dynamic> cardList = message['payload']['card'];
            cardList.forEach((link) {
              card.add(LinkCard(
                link: link["link"],
                title: link["title"],
              ));
              afterCardTitle = message['payload']['afterCardTitle'];
            });
          }
        } catch (e) {
          print("ERROR in QuickReply $e");
        }
      }
    });
  }
}
