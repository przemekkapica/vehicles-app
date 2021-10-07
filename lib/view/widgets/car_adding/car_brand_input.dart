import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/car_adding_form_bloc.dart';

class CarBrandInput extends StatelessWidget {
  const CarBrandInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarAddingFormBloc, CarAddingFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.brand.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.brand,
            errorText: state.brand.invalid
                ? AppLocalizations.of(context)!.brandInvalidMessage
                : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context
                .read<CarAddingFormBloc>()
                .add(CarBrandChanged(brand: value));
          },
          textInputAction: TextInputAction.next,
          key: const Key('carBrandInput'),
        );
      },
    );
  }
}
