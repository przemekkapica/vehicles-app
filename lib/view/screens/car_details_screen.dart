import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:vehicles_app/data/models/car.dart';
import 'package:vehicles_app/view/widgets/car_details/car_details.dart';
import 'package:vehicles_app/view/widgets/car_details/car_location.dart';
import 'package:vehicles_app/view/widgets/languages_popup_menu_button.dart';

class CarDetailsScreen extends StatelessWidget {
  CarDetailsScreen({Key? key, required this.car}) : super(key: key);

  final Car car;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(
          fit: BoxFit.contain,
          child: Text(
            AppLocalizations.of(context)!.carDetails,
            key: const Key('carDetailsScreenTitle'),
          ),
        ),
        centerTitle: true,
        actions: [
          LanguagesPopupMenuButton(),
        ],
        leading: IconButton(
          icon: Icon(Icons.chevron_left),
          onPressed: () => Navigator.pop(context),
          key: const Key('carDetailsPageBackButton'),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarLocation(car: car),
            CarDetailsView(car: car),
          ],
        ),
      ),
    );
  }
}
