import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OdiColors {
  static const Color appColor = Color(0xFF003171);
  static const Color darkerGreen = Color(0xff001939);
  static const Color bottomBetSlip = Color(0xFF00459f);
  static const Color bottomLogin = Color(0xFF003171);
  static const Color topBackground = Color.fromARGB(255, 51, 51, 51);
  static const Color oddBorder = Color.fromARGB(255, 204, 204, 204);
  static const Color mpesaBannerBackground = Color(0xFF404040);
  static const Color odiLeagueDefaultColor = Color.fromRGBO(46, 0, 50, 1.0);
  static const Color odiLeagueBetSlipColor = Color.fromRGBO(255, 255, 255, 0.2);
  static const Color odiLeagueMyBetsButtonColor =
      Color.fromRGBO(255, 255, 255, 0.3);

  static const Color oddLightBackground = Color(0xffEBEBEB);
  static const Color oddDarkBackground = Color.fromRGBO(64, 64, 64, 1);

  static const Color appLightBackground = Color(0xFFF2f4F6);
  static const Color appDarkBackground = Color.fromRGBO(26, 26, 26, 1);

  static const Color leagueTitleLightColor = Color(0xFFe7e7e7);
  static const Color leagueTitleDarkColor = Color.fromRGBO(44, 44, 44, 1);

  static const Color trendingLeagueLightColor =
      Color(0xffEBEBEB);
  static const Color trendingLeagueDarkColor = Color.fromRGBO(36, 36, 36, 1);

  static const Color yellowLightColor = Color(0xfff9EB38);
  static const Color yellowDarkColor = Color.fromRGBO(250, 236, 29, 1.0);

  Color oddBackgroundThemed(BuildContext context) {
    return isLightThemed(context) ? oddLightBackground : oddDarkBackground;
  }

  Color appBackgroundThemed(BuildContext context) {
    return isLightThemed(context) ? appLightBackground : appDarkBackground;
  }

  Color trendingLeagueTitle(BuildContext context) {
    return isLightThemed(context)
        ? trendingLeagueLightColor
        : trendingLeagueDarkColor;
  }

  Color leagueTitleColorThemed(BuildContext context) {
    return isLightThemed(context)
        ? leagueTitleLightColor
        : leagueTitleDarkColor;
  }

  Color yellowColorThemed(BuildContext context) {
    return isLightThemed(context) ? yellowLightColor : yellowDarkColor;
  }
}

bool isLightThemed(BuildContext context) {
  return Theme.of(context).brightness == Brightness.light;
}
