import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:vehicles_app/constants/locales.dart';
import 'package:vehicles_app/data/models/person.dart';
import 'package:vehicles_app/helpers/language_notifier.dart';
import 'package:vehicles_app/logic/blocs/person_data/bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CarOwnerDetails extends StatelessWidget {
  final String id;

  CarOwnerDetails({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PersonDataBloc, PersonDataState>(
      builder: (context, state) {
        if (state is PersonListEmpty) {
          BlocProvider.of<PersonDataBloc>(context)
              .add(GetPersonDetails(id: id));
        }
        if (state is PersonDetailsError) {
          return Center(
            child: Text(AppLocalizations.of(context)!.failedToLoadPersonList),
          );
        }
        if (state is PersonDetailsLoaded) {
          return CarOwnerDetailsContainer(person: state.person);
        }
        if (state is PersonDetailsNotFound) {
          return CarOwnerDetailsContainer(person: null);
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}

class CarOwnerDetailsContainer extends StatelessWidget {
  final Person? person;

  const CarOwnerDetailsContainer({Key? key, required this.person})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(Icons.person),
          Flexible(
            child: Container(),
            flex: 1,
          ),
          buildPersonDetails(context),
          Flexible(
            child: Container(),
            flex: 15,
          ),
        ],
      ),
    );
  }

  Widget buildPersonDetails(context) {
    if (person == null) {
      return Text(AppLocalizations.of(context)!.ownerNotAvailble);
    } else {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPersonBirthInfo(context),
          buildPersonFullName(context),
        ],
      );
    }
  }

  Text buildPersonBirthInfo(context) {
    return Text(
      '${person!.firstName} ${person!.lastName} ${Provider.of<LanguageChangeNotifierProvider>(context, listen: true).currentLocale == EN ? '(${person!.sex.toUpperCase()})' : ''}',
      style: Theme.of(context).textTheme.headline6,
    );
  }

  Text buildPersonFullName(context) {
    return Text(
      '${person!.sex == 'M' ? AppLocalizations.of(context)!.bornOnMale : AppLocalizations.of(context)!.bornOnFemale} ${DateFormat.yMMMd(Provider.of<LanguageChangeNotifierProvider>(context, listen: true).currentLocaleString).format(DateTime.parse(person!.birthDate))}',
    );
  }
}
