import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicles_app/data/models/person.dart';
import 'package:vehicles_app/logic/blocs/car_adding_form/bloc.dart';
import 'package:vehicles_app/logic/blocs/person_data/bloc.dart';
import 'package:vehicles_app/view/widgets/car_adding/car_brand_input.dart';
import 'package:vehicles_app/view/widgets/car_adding/car_date_input.dart';
import 'package:vehicles_app/view/widgets/car_adding/car_model_input.dart';
import 'package:vehicles_app/view/widgets/car_adding/car_registration.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasicInformationForm extends StatefulWidget {
  BasicInformationForm({required this.callback, Key? key}) : super(key: key);

  final Function(PersonData) callback;

  @override
  _AddingCarFormController createState() =>
      _AddingCarFormController(personDataCallback: callback);
}

class _AddingCarFormController extends State<BasicInformationForm> {
  _AddingCarFormController({required this.personDataCallback});

  final _brandFocusNode = FocusNode();
  final _modelFocusNode = FocusNode();
  final _registrationFocusNode = FocusNode();
  final _dateFocusNode = FocusNode();

  Function(PersonData) personDataCallback;

  var _selectedOwnerId;

  void _setCurrentOwnerId(ownerId) {
    setState(() {
      _selectedOwnerId = ownerId;
    });
  }

  @override
  void initState() {
    super.initState();
    _brandFocusNode.addListener(() {
      if (!_brandFocusNode.hasFocus) {
        context.read<CarAddingFormBloc>().add(CarBrandUnfocused());
      }
    });
    _modelFocusNode.addListener(() {
      if (!_modelFocusNode.hasFocus) {
        context.read<CarAddingFormBloc>().add(CarModelUnfocused());
      }
    });
    _registrationFocusNode.addListener(() {
      if (!_registrationFocusNode.hasFocus) {
        context.read<CarAddingFormBloc>().add(CarRegistrationUnfocused());
      }
    });
    _dateFocusNode.addListener(() {
      if (!_dateFocusNode.hasFocus) {
        context.read<CarAddingFormBloc>().add(CarDateUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _brandFocusNode.dispose();
    _modelFocusNode.dispose();
    _registrationFocusNode.dispose();
    _dateFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _AddingCarFormView(state: this);
  }
}

class _AddingCarFormView extends StatelessWidget {
  const _AddingCarFormView({required this.state, Key? key}) : super(key: key);

  final _AddingCarFormController state;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonDataBloc, PersonDataState>(
      builder: (context, state) {
        if (state is PersonListEmpty) {
          BlocProvider.of<PersonDataBloc>(context).add(GetPersonList());
        }
        if (state is PersonListError) {
          return buildBasicInformationForm(context, personDataList: null);
        }
        if (state is PersonListLoaded) {
          List<Person> personList = state.personList;
          List<PersonData> personDataList = [];

          for (var person in personList) {
            var personData = PersonData(
                fullName: '${person.firstName} ${person.lastName}',
                id: person.id);
            personDataList.add(personData);
          }
          return buildBasicInformationForm(context,
              personDataList: personDataList);
        }
        return buildBasicInformationForm(context, personDataList: null);
      },
    );
  }

  Widget buildBasicInformationForm(context,
      {List<PersonData>? personDataList}) {
    return Column(
      children: <Widget>[
        CarBrandInput(focusNode: state._brandFocusNode),
        SizedBox(height: 20),
        CarModelInput(focusNode: state._modelFocusNode),
        SizedBox(height: 20),
        CarRegistrationInput(focusNode: state._registrationFocusNode),
        SizedBox(height: 20),
        CarDateInput(focusNode: state._dateFocusNode),
        SizedBox(height: 24),
        buildDropdown(context, personDataList),
      ],
    );
  }

  Widget buildDropdown(context, List<PersonData>? personDataList) {
    if (personDataList != null) {
      return DropdownButton<String>(
        items: personDataList.map((PersonData personData) {
          return DropdownMenuItem<String>(
            value: personData.id,
            child: Text(personData.fullName),
            key: new Key(personData.fullName),
          );
        }).toList(),
        value: state._selectedOwnerId,
        onChanged: (value) {
          state._setCurrentOwnerId(value);
          state.personDataCallback(personDataList
              .firstWhere((personData) => personData.id == value));
        },
        isExpanded: true,
        hint: Text(AppLocalizations.of(context)!.selectOwner),
        key: const Key('carOwnerDropdown'),
      );
    } else {
      return DropdownButton<String>(
        items: [],
        isExpanded: true,
        hint: Text(AppLocalizations.of(context)!.selectOwner),
      );
    }
  }
}

class PersonData {
  String fullName;
  String id;

  PersonData({required this.fullName, required this.id});
}
