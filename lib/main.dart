import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicles_app/constants/constants.dart';
import 'package:vehicles_app/helpers/language_notifier.dart';
import 'package:vehicles_app/view/routes/app_router.dart';
import 'package:vehicles_app/styles/app_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(VehiclesApp());
}

class VehiclesApp extends StatelessWidget {
  final AppRouter appRouter = AppRouter();
  final AppTheme appTheme = AppTheme();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<LanguageChangeNotifierProvider>(
      create: (context) => LanguageChangeNotifierProvider(),
      child: Builder(
        builder: (context) => MaterialApp(
          title: APP_TITLE,
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale:
              Provider.of<LanguageChangeNotifierProvider>(context, listen: true)
                  .currentLocale,
          supportedLocales: [EN, PL],
          debugShowCheckedModeBanner: false,
          theme: appTheme.theme(context),
          onGenerateRoute: appRouter.onGenerateRoute,
        ),
      ),
    );
  }
}
