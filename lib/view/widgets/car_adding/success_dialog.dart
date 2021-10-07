import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:vehicles_app/constants/strings.dart';

class SuccessDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppLocalizations.of(context)!.vehicleAddedSuccessfully,
              softWrap: true,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButton(
              child: Text(AppLocalizations.of(context)!.ok),
              onPressed: () => Navigator.pushNamed(context, CAR_LIST_ROUTE),
            ),
          ],
        ),
      ),
    );
  }
}
