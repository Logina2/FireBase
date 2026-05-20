import 'package:flutter/material.dart';

class NavigationKey {
  NavigationKey._();

  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();
}
