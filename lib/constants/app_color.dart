import 'package:flutter/material.dart';
class ColorApp{
  static Color PrimaryColor  =   HexColor("#015555");
  static Color introbackgroundColor  =   HexColor("#E5EEEE");
  static Color WightColor  =  Colors.white;

  static Color logInTextColor  =   HexColor("#80AAAA");
  static Color greyColor  =   HexColor("#475467");
  static Color greyIntroColor  =   HexColor("#EAECF0");
  static Color greyIntroColor2  =   HexColor("#667085");
  static Color otpColorBack  =   HexColor("#F2F5F5");
  static Color SecondaryColor  =   HexColor("#FF5745");
  static Color SuccessColor  =   HexColor("#32D583");


}
class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}