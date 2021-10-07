import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:vehicles_app/data/models/car.dart';

class CarLocation extends StatelessWidget {
  CarLocation({required this.car, Key? key}) : super(key: key);

  final Car car;

  final Future _googleMapFuture =
      Future.delayed(Duration(milliseconds: 250), () => true);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.62 * MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: _googleMapFuture,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Container();
          }
          return GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(car.latitude, car.longitude),
              zoom: 16,
            ),
            markers: Set<Marker>.of([
              Marker(
                markerId: MarkerId(car.id),
                position: LatLng(car.latitude, car.longitude),
              )
            ]),
            key: const Key('googleMapCarLocation'),
          );
        },
      ),
    );
  }
}
