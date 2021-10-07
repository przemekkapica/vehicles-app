import 'package:equatable/equatable.dart';
import 'package:vehicles_app/data/models/models.dart';

abstract class PersonDataState extends Equatable {
  const PersonDataState();

  @override
  List<Object> get props => [];
}

class PersonListEmpty extends PersonDataState {}

class PersonListLoading extends PersonDataState {}

class PersonListLoaded extends PersonDataState {
  final List<Person> personList;

  const PersonListLoaded({required this.personList});

  @override
  List<Object> get props => [personList];
}

class PersonListError extends PersonDataState {}

class PersonDetailsEmpty extends PersonDataState {}

class PersonDetailsLoading extends PersonDataState {}

class PersonDetailsLoaded extends PersonDataState {
  final Person person;

  const PersonDetailsLoaded({required this.person});

  @override
  List<Object> get props => [person];
}

class PersonDetailsNotFound extends PersonDataState {}

class PersonDetailsError extends PersonDataState {}
