import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicles_app/constants/locales.dart';
import 'package:vehicles_app/helpers/language_notifier.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguagesPopupMenuButton extends StatelessWidget {
  const LanguagesPopupMenuButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      color: Colors.white,
      itemBuilder: (context) => [
        PopupMenuItem<String>(
          value: EN_STRING,
          child: Row(
            children: [
              Image.asset(
                'icons/flags/png/us.png',
                package: 'country_icons',
                width: 34,
              ),
              SizedBox(width: 14),
              Text(
                AppLocalizations.of(context)!.english,
              ),
            ],
          ),
          key: const Key('englishLangSwitcher'),
        ),
        PopupMenuItem<String>(
          value: PL_STRING,
          child: Row(
            children: [
              Image.asset(
                'icons/flags/png/pl.png',
                package: 'country_icons',
                width: 34,
              ),
              SizedBox(width: 14),
              Text(
                AppLocalizations.of(context)!.polish,
              ),
            ],
          ),
          key: const Key('polishLangSwitcher'),
        ),
      ],
      onSelected: (String localeString) {
        context
            .read<LanguageChangeNotifierProvider>()
            .changeLocaleFromString(localeString);
      },
      icon: Icon(Icons.language),
      key: const Key('languagePopupButton'),
    );
  }
}
