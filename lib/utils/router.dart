import 'package:flutter/cupertino.dart';
import 'package:fv1/ui/screens/home.dart';

void pushOnTopOfHome(BuildContext context, String newRouteName) {
  Navigator.of(context).pushNamedAndRemoveUntil(
    newRouteName,
    (route) => route.settings.name == HomeScreen.route,
  );
}
