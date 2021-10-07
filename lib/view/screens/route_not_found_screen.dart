import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RouteNotFoundScreen extends StatelessWidget {
  RouteNotFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text(AppLocalizations.of(context)!.pageNotFound),
        ),
      ),
    );
  }
}
