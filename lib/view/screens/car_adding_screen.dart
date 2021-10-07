import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vehicles_app/view/widgets/car_adding/form_stepper.dart';
import 'package:vehicles_app/view/widgets/languages_popup_menu_button.dart';

class CarAddingScreen extends StatelessWidget {
  CarAddingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            AppLocalizations.of(context)!.addingNewCar,
            key: const Key('carAddingScreenTitle'),
          ),
        ),
        centerTitle: true,
        actions: [
          LanguagesPopupMenuButton(),
        ],
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          key: const Key('carAddingScreenBackButton'),
        ),
      ),
      body: FormStepper(),
    );
  }
}
