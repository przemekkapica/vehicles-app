import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/car_adding_form_bloc.dart';

class CarModelInput extends StatelessWidget {
  const CarModelInput({Key? key, required this.focusNode}) : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarAddingFormBloc, CarAddingFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.model.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.model,
            errorText: state.model.invalid
                ? AppLocalizations.of(context)!.modelInvalidMessage
                : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context
                .read<CarAddingFormBloc>()
                .add(CarModelChanged(model: value));
          },
          textInputAction: TextInputAction.next,
          key: const Key('carModelInput'),
        );
      },
    );
  }
}
