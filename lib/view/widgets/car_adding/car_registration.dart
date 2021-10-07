import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/car_adding_form_bloc.dart';

class CarRegistrationInput extends StatelessWidget {
  const CarRegistrationInput({Key? key, required this.focusNode})
      : super(key: key);

  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarAddingFormBloc, CarAddingFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.registration.value,
          focusNode: focusNode,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.registration,
            errorText: state.registration.invalid
                ? AppLocalizations.of(context)!.registrationInvalidMessage
                : null,
          ),
          keyboardType: TextInputType.text,
          onChanged: (value) {
            context
                .read<CarAddingFormBloc>()
                .add(CarRegistrationChanged(registration: value));
          },
          textInputAction: TextInputAction.next,
          key: const Key('carRegistrationInput'),
        );
      },
    );
  }
}
