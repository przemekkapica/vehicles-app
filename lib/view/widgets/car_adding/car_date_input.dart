import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';

class CarDateInput extends StatelessWidget {
  CarDateInput({required this.focusNode, Key? key}) : super(key: key);

  final FocusNode focusNode;

  final dateMaskFormatter = new MaskTextInputFormatter(
    mask: '####/##/##',
    filter: {"#": RegExp(r'[0-9]')},
  );

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarAddingFormBloc, CarAddingFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.date.value,
          focusNode: focusNode,
          decoration: InputDecoration(
              labelText: AppLocalizations.of(context)!.date,
              errorText: state.date.invalid
                  ? AppLocalizations.of(context)!.dateInvalidMessage
                  : null,
              hintText: AppLocalizations.of(context)!.exampleDate),
          keyboardType: TextInputType.number,
          inputFormatters: [dateMaskFormatter],
          onChanged: (value) {
            context.read<CarAddingFormBloc>().add(CarDateChanged(date: value));
          },
          textInputAction: TextInputAction.done, // this is the last input
          key: const Key('carDateInput'),
        );
      },
    );
  }
}
