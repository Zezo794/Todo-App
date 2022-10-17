// baseUrl:https://newsapi.org/
// method(Url):v2/top-headlines?
// query:country=us&category=business&apiKey=46bc5e0eccc941c99ca85c24563fbd86


import '../network/local/Cash_helper.dart';
import 'componanets.dart';



void showAlltext(String text)
{
  final pattern = RegExp('.{1,800}');
  pattern.allMatches(text).forEach((element) {
    print(element.group(0));
  });
}

  String? token = '';
String? UId = '';
