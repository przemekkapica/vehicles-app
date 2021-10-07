import 'package:flutter/material.dart';
import 'package:vehicles_app/data/models/car.dart';
import 'package:vehicles_app/helpers/string_helpers.dart';
import 'package:vehicles_app/view/widgets/car_details/car_owner_details.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:auto_size_text/auto_size_text.dart';

class CarDetailsView extends StatelessWidget {
  final Car car;

  const CarDetailsView({Key? key, required this.car}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      decoration: BoxDecoration(boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.black54,
          blurRadius: 5.0,
          spreadRadius: -2.0,
          offset: Offset(0.0, -4),
        )
      ], color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildSectionSeperator(
            context,
            AppLocalizations.of(context)!.vehicleOverview.toUpperCase(),
          ),
          SizedBox(height: 7),
          buildCarDetails(context),
          SizedBox(height: 20),
          buildSectionSeperator(
            context,
            AppLocalizations.of(context)!.ownerDetails.toUpperCase(),
          ),
          SizedBox(height: 9),
          CarOwnerDetails(id: car.ownerId),
        ],
      ),
    );
  }

  Row buildCarDetails(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          constraints: BoxConstraints(maxWidth: 300),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AutoSizeText.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.headline5,
                  children: <TextSpan>[
                    TextSpan(
                        text: car.brand.capitalizeFirstLetter(),
                        style: TextStyle(fontWeight: FontWeight.w600)),
                    TextSpan(
                      text: ' ' + car.model.capitalizeFirstLetter(),
                    ),
                  ],
                ),
                softWrap: true,
                maxLines: 2,
              ),
              Text(
                formatRegistrationNumber(car.registration),
                style: Theme.of(context).textTheme.headline6,
              ),
            ],
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(3.0),
          child: Container(
            height: 30.0,
            width: 30.0,
            decoration: BoxDecoration(
                color: Color(int.parse('0xFF' + car.color.substring(1))),
                border: Border.all(color: Colors.grey[900]!)),
          ),
        )
      ],
    );
  }

  Row buildSectionSeperator(BuildContext context, String sectionName) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
            endIndent: 10,
          ),
        ),
        Text(
          sectionName,
          style: Theme.of(context)
              .textTheme
              .caption
              ?.copyWith(color: Colors.deepOrange, fontWeight: FontWeight.w900),
        ),
        Expanded(
          child: Divider(
            thickness: 0.5,
            color: Colors.grey[400],
            indent: 10,
          ),
        ),
      ],
    );
  }
}
