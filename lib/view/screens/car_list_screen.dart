import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vehicles_app/constants/constants.dart';
import 'package:vehicles_app/constants/strings.dart';
import 'package:vehicles_app/helpers/language_notifier.dart';
import 'package:vehicles_app/view/widgets/car_list/car_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vehicles_app/view/widgets/languages_popup_menu_button.dart';

class CarListScreen extends StatelessWidget {
  CarListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            AppLocalizations.of(context)!.availbleCars,
            key: const Key('carListScreenTitle'),
          ),
        ),
        centerTitle: true,
        actions: [
          LanguagesPopupMenuButton(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed(ADDING_CAR_ROUTE),
        child: Icon(
          Icons.add_outlined,
          size: 30,
        ),
        key: const Key('moveToCarFormButton'),
      ),
      body: CarList(),
    );
  }
}
