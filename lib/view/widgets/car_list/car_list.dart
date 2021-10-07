import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicles_app/constants/strings.dart';
import 'package:vehicles_app/helpers/string_helpers.dart';
import 'package:vehicles_app/logic/blocs/car_data/bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarDataBloc, CarDataState>(
      builder: (context, state) {
        if (state is CarListEmpty) {
          BlocProvider.of<CarDataBloc>(context).add(GetCarList());
        }
        if (state is CarListError) {
          return Center(
            child: Text(AppLocalizations.of(context)!.failedToLoadCarList),
          );
        }
        if (state is CarListLoaded) {
          return ListView.builder(
            itemCount: state.carList.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Transform.translate(
                  offset: Offset(-10, 0),
                  child: RichText(
                    text: TextSpan(
                      style: Theme.of(context).textTheme.subtitle1,
                      children: [
                        TextSpan(
                          text:
                              '${state.carList[index].brand.capitalizeFirstLetter()} ',
                          style: TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(
                            text: state.carList[index].model
                                .capitalizeFirstLetter())
                      ],
                    ),
                  ),
                ),
                subtitle: Transform.translate(
                  offset: Offset(-10, 0),
                  child: Text(
                    formatRegistrationNumber(state.carList[index].registration),
                    style: TextStyle(color: Colors.grey[800]),
                  ),
                ),
                leading: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(3.0),
                      child: Container(
                        height: 25.0,
                        width: 25.0,
                        decoration: BoxDecoration(
                          color: Color(int.parse('0xFF' +
                              state.carList[index].color.substring(1))),
                          border: Border.all(color: Colors.grey[900]!),
                        ),
                      ),
                    ),
                  ],
                ),
                onTap: () => moveToCarDetailsScreen(context, state, index),
                key: new Key('carListItem${index.toString()}'),
              );
            },
            key: const Key('carList'),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  Future<void> moveToCarDetailsScreen(
      BuildContext context, CarListLoaded state, int index) async {
    await Navigator.pushNamed(
      context,
      CAR_DETAILS_ROUTE,
      arguments: state.carList[index],
    );
  }
}
