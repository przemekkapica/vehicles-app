import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicles_app/constants/strings.dart';
import 'package:vehicles_app/data/models/car.dart';
import 'package:vehicles_app/data/repositories/car_repository.dart';
import 'package:vehicles_app/data/repositories/person_repository.dart';
import 'package:vehicles_app/data/services/vehicles_service.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/car_adding_form_bloc.dart';
import 'package:vehicles_app/logic/blocs/car_data/car_data_bloc.dart';
import 'package:vehicles_app/logic/blocs/person_data/bloc.dart';
import 'package:vehicles_app/view/screens/car_adding_screen.dart';
import 'package:vehicles_app/view/screens/car_details_screen.dart';
import 'package:vehicles_app/view/screens/car_list_screen.dart';
import 'package:vehicles_app/view/screens/route_not_found_screen.dart';

class AppRouter {
  late VehiclesService vehiclesService;
  late PersonRepository personRepository;
  late CarRepository carRepository;

  AppRouter() {
    vehiclesService = VehiclesService();
    personRepository = PersonRepository(vehiclesService: vehiclesService);
    carRepository = CarRepository(vehiclesService: vehiclesService);
  }

  Route onGenerateRoute(RouteSettings routeSettings) {
    final args = routeSettings.arguments;

    switch (routeSettings.name) {
      case CAR_LIST_ROUTE:
        return MaterialPageRoute(
          builder: (BuildContext context) => BlocProvider.value(
            value: CarDataBloc(carRepository: carRepository),
            child: CarListScreen(),
          ),
        );

      case CAR_DETAILS_ROUTE:
        if (args is Car) {
          return MaterialPageRoute(
            builder: (BuildContext context) => BlocProvider.value(
              value: PersonDataBloc(personRepository: personRepository),
              child: CarDetailsScreen(
                car: args,
              ),
            ),
          );
        } else {
          return MaterialPageRoute(builder: (_) => RouteNotFoundScreen());
        }

      case ADDING_CAR_ROUTE:
        return MaterialPageRoute(
          builder: (BuildContext context) => MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (_) =>
                    PersonDataBloc(personRepository: personRepository),
              ),
              BlocProvider(
                create: (_) =>
                    CarAddingFormBloc(vehiclesService: vehiclesService),
              ),
            ],
            child: CarAddingScreen(),
          ),
        );

      default:
        return MaterialPageRoute(builder: (_) => RouteNotFoundScreen());
    }
  }
}
