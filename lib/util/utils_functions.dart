import 'dart:io';
import 'dart:ui';
import 'dart:math' as math;

//------------- STRING
String capitalizeFirstLetterString(String word){
  return word.replaceFirst(word[0], word[0].toUpperCase());
}

String removeHtmlTags(String words){
  return words.replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), '');
}

//------------- COLOR
Color parseColorFromDb(String color){
  return Color(int.parse(color.substring(6, 16)));
}

Color getRandomColor(){
  return Color((math.Random().nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
}

Color darkenColor(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var f = 1 - percent / 100;
  return Color.fromARGB(
      c.alpha,
      (c.red * f).round(),
      (c.green  * f).round(),
      (c.blue * f).round()
  );
}

Color lightenColor(Color c, [int percent = 10]) {
  assert(1 <= percent && percent <= 100);
  var p = percent / 100;
  return Color.fromARGB(
      c.alpha,
      c.red + ((255 - c.red) * p).round(),
      c.green + ((255 - c.green) * p).round(),
      c.blue + ((255 - c.blue) * p).round()
  );
}