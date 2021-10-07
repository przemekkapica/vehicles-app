import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:vehicles_app/constants/strings.dart';

// ignore: must_be_immutable
class LocationPicker extends StatelessWidget {
  LocationPicker({
    required this.nextStepCallback,
    required this.locationCallback,
    Key? key,
  }) : super(key: key);

  final Function nextStepCallback;
  final Function(double, double) locationCallback;

  final kInitialPosition = LatLng(52.229804, 21.011723);

  var selectedPlaceLat;
  var selectedPlaceLng;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: 500),
      child: PlacePicker(
        apiKey: GOOGLE_API_KEY,
        initialPosition: kInitialPosition,
        useCurrentLocation: false,
        selectInitialPosition: true,
        automaticallyImplyAppBarLeading: false,
        selectedPlaceWidgetBuilder:
            (_, selectedPlace, state, isSearchBarFocused) {
          return isSearchBarFocused
              ? Container()
              : FloatingCard(
                  bottomPosition: 8.0,
                  leftPosition: 70.0,
                  rightPosition: 70.0,
                  color: Colors.transparent,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      textStyle: MaterialStateProperty.all(
                          Theme.of(context).textTheme.subtitle1),
                    ),
                    child: Text(
                      AppLocalizations.of(context)!.pickHere,
                    ),
                    onPressed: () {
                      selectedPlaceLat = selectedPlace!.geometry!.location.lat;
                      selectedPlaceLng = selectedPlace.geometry!.location.lng;
                      locationCallback(selectedPlaceLat, selectedPlaceLng);
                      nextStepCallback(); // location selection automatically moves to the next form's step
                    },
                    key: const Key('submitLocationButton'),
                  ),
                );
        },
        key: const Key('locationPicker'),
      ),
    );
  }
}
