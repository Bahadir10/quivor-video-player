import 'package:flutter/material.dart';

abstract class INavigationController {
  final Widget? Function(String route, dynamic data) routes;

//  final void Function(String route, dynamic data);
  INavigationController(this.routes);
  void go(String route, BuildContext context, {dynamic data});
  void goOffAll(String route, BuildContext context, {dynamic data});
  void off(BuildContext context);
}

abstract class INavigationParameters {}

final class NavigationController extends INavigationController {
  NavigationController(super.routes);

  @override
  void go(String route, BuildContext context, {dynamic data}) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => routes(route, data) ?? Scaffold(),
        ));
  }

  @override
  void off(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  void goOffAll(String route, BuildContext context, {data}) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => routes(route, data) ?? Scaffold(),
        ),
        (Route<dynamic> route) => false);
  }
}
