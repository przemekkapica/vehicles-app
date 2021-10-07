import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_hsvcolor_picker/flutter_hsvcolor_picker.dart';
import 'package:vehicles_app/data/models/dto/car_dto.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';
import 'package:vehicles_app/view/widgets/car_adding/basic_car_information_form.dart';
import 'package:formz/formz.dart';
import 'package:vehicles_app/view/widgets/car_adding/location_picker.dart';
import 'package:vehicles_app/view/widgets/car_adding/success_dialog.dart';

class FormStepper extends StatefulWidget {
  FormStepper({Key? key}) : super(key: key);

  @override
  _FormStepperController createState() => _FormStepperController();
}

class _FormStepperController extends State<FormStepper> {
  StepperType stepperType = StepperType.vertical;

  int _currentStep = 0;

  String _ownerId = '';
  String _ownerFullName = '';
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _colorAsString = '#000000';
  var _color;

  _carOwnerCallback(PersonData personData) {
    setState(() {
      _ownerId = personData.id;
      _ownerFullName = personData.fullName;
    });
  }

  _locationCallback(double lat, double lng) {
    setState(() {
      _latitude = lat;
      _longitude = lng;
    });
  }

  _onColorChange(value) {
    setState(() {
      _color = value;
      _colorAsString = '#${_color.toString().substring(10, 16)}';
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text(message)),
      );
  }

  onStepTapped(int step) {
    setState(() => _currentStep = step);
  }

  void _moveToNextStep() {
    if (_currentStep < 3)
      setState(() => _currentStep += 1);
    else {
      _submitForm();
    }
  }

  void _moveToPreviousStep() {
    _currentStep > 0
        ? setState(() => _currentStep -= 1)
        : Navigator.pop(context);
  }

  void _submitForm() {
    final String brand = context.read<CarAddingFormBloc>().state.brand.value;
    final String model = context.read<CarAddingFormBloc>().state.model.value;
    final String registration =
        context.read<CarAddingFormBloc>().state.registration.value;
    final String date = context.read<CarAddingFormBloc>().state.date.value;

    final carToBeAdded = CarDTO(
      brand: brand,
      model: model,
      color: _colorAsString,
      registration: registration,
      year: date,
      ownerId: _ownerId,
      latitude: _latitude,
      longitude: _longitude,
    );

    context.read<CarAddingFormBloc>().add(FormSubmitted(car: carToBeAdded));
  }

  @override
  Widget build(BuildContext context) {
    return _FormStepperView(state: this);
  }
}

class _FormStepperView extends StatelessWidget {
  _FormStepperView({required this.state, Key? key}) : super(key: key);

  final _FormStepperController state;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CarAddingFormBloc, CarAddingFormState>(
      listener: (context, blocState) {
        if (blocState.status.isSubmissionSuccess) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          showDialog<void>(
            context: context,
            builder: (_) => SuccessDialog(),
          );
        }
        if (blocState.status.isSubmissionInProgress) {
          state._showSnackbar(context,
              AppLocalizations.of(context)!.addingNewVehicleInProgress);
        }
        if (blocState.status.isSubmissionFailure) {
          state._showSnackbar(context, blocState.errorMessage);
        }
      },
      child: BlocBuilder<CarAddingFormBloc, CarAddingFormState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, blocState) {
          return Column(
            children: [
              buildStepper(context),
            ],
          );
        },
      ),
    );
  }

  Expanded buildStepper(BuildContext context) {
    return Expanded(
      child: Stepper(
        type: StepperType.vertical,
        physics: ScrollPhysics(),
        currentStep: state._currentStep,
        onStepTapped: (step) => state.onStepTapped(step),
        onStepContinue: state._moveToNextStep,
        onStepCancel: state._moveToPreviousStep,
        controlsBuilder: (BuildContext context,
            {VoidCallback? onStepContinue, VoidCallback? onStepCancel}) {
          return stepperControlls(context, state);
        },
        steps: <Step>[
          mainInfoStep(context),
          colorStep(context),
          locationStep(context),
          overviewStep(context)
        ],
      ),
    );
  }

  Step mainInfoStep(BuildContext context) {
    return Step(
      title: Text(
        AppLocalizations.of(context)!.basicInformation,
        style: TextStyle(
            color: state._currentStep >= 0 ? Colors.grey[900] : Colors.grey),
      ),
      isActive: state._currentStep >= 0,
      state: state._currentStep > 0 ? StepState.complete : StepState.disabled,
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              BasicInformationForm(
                callback: state._carOwnerCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Step colorStep(BuildContext context) {
    return Step(
      title: Text(
        AppLocalizations.of(context)!.carColor,
        style: TextStyle(
            color: state._currentStep >= 1 ? Colors.grey[900] : Colors.grey),
        key: const Key('colorStepTitle'),
      ),
      isActive: state._currentStep >= 1,
      state: state._currentStep > 1 ? StepState.complete : StepState.disabled,
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ColorPicker(
                color: Colors.black,
                onChanged: (value) {
                  state._onColorChange(value);
                },
                initialPicker: Picker.paletteHue,
                key: const Key('colorPicker'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Step locationStep(BuildContext context) {
    return Step(
      title: Text(
        AppLocalizations.of(context)!.location,
        style: TextStyle(
            color: state._currentStep >= 2 ? Colors.grey[900] : Colors.grey),
        key: const Key('locationStepTitle'),
      ),
      isActive: state._currentStep >= 2,
      state: state._currentStep > 2 ? StepState.complete : StepState.disabled,
      content: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              LocationPicker(
                nextStepCallback: state._moveToNextStep,
                locationCallback: state._locationCallback,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Step overviewStep(BuildContext context) {
    return Step(
      title: Text(
        AppLocalizations.of(context)!.overview,
        style: TextStyle(
            color: state._currentStep >= 3 ? Colors.grey[900] : Colors.grey),
      ),
      isActive: state._currentStep >= 3,
      state: state._currentStep > 3 ? StepState.complete : StepState.disabled,
      content: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          child: buildOverviewStepTable(context),
        ),
      ),
    );
  }

  Table buildOverviewStepTable(BuildContext context) {
    return Table(
      children: [
        TableRow(children: [
          buildTableCell(context, AppLocalizations.of(context)!.brand,
              context.read<CarAddingFormBloc>().state.brand.value),
          buildTableCell(context, AppLocalizations.of(context)!.model,
              context.read<CarAddingFormBloc>().state.model.value),
        ]),
        TableRow(children: [
          buildTableCell(context, AppLocalizations.of(context)!.ownerName,
              state._ownerFullName),
          buildTableCell(context, AppLocalizations.of(context)!.registration,
              context.read<CarAddingFormBloc>().state.registration.value),
        ]),
        TableRow(children: [
          buildTableCell(context, AppLocalizations.of(context)!.carColor,
              state._colorAsString),
          buildTableCell(
              context,
              AppLocalizations.of(context)!.registrationDate,
              context.read<CarAddingFormBloc>().state.date.value),
        ]),
      ],
    );
  }

  Container buildTableCell(BuildContext context, String label, String value) {
    final String key =
        'overview' + label.replaceAll(' ', '').replaceAll("'", '');

    return Container(
      constraints: BoxConstraints(maxHeight: 50),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: Theme.of(context).textTheme.overline,
          ),
          Text(
            value,
            style: Theme.of(context)
                .textTheme
                .bodyText1!
                .copyWith(fontWeight: FontWeight.w600),
            key: new Key(key),
          ),
        ],
      ),
    );
  }

  Widget stepperControlls(BuildContext context, _FormStepperController state) {
    return state._currentStep != 2
        ? Container(
            margin: const EdgeInsets.only(top: 25.0),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                buildStepperBackButton(state, context),
                Padding(padding: EdgeInsets.all(5)),
                buildStepperNextButton(state),
              ],
            ),
          )
        : Container(height: 0);
  }

  Expanded buildStepperNextButton(_FormStepperController state) {
    return Expanded(
      child: BlocBuilder<CarAddingFormBloc, CarAddingFormState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, blocState) {
          return ElevatedButton(
            style: ButtonStyle(
              textStyle: MaterialStateProperty.all(
                  Theme.of(context).textTheme.subtitle1),
            ),
            onPressed: blocState.status.isValidated && state._ownerId != ''
                ? () => state._moveToNextStep()
                : null,
            child: state._currentStep < 3
                ? Text(AppLocalizations.of(context)!.next)
                : Text(AppLocalizations.of(context)!.submit),
            key: const Key('stepperNextButton'),
          );
        },
      ),
    );
  }

  Expanded buildStepperBackButton(
      _FormStepperController state, BuildContext context) {
    return Expanded(
      child: OutlinedButton(
        onPressed: state._moveToPreviousStep,
        child: Text(
          AppLocalizations.of(context)!.back,
          style: Theme.of(context).textTheme.subtitle1,
        ),
        key: const Key('stepperBackButton'),
      ),
    );
  }
}
