import 'package:equatable/equatable.dart';

abstract class PersonDataEvent extends Equatable {
  const PersonDataEvent();
}

class GetPersonList extends PersonDataEvent {
  const GetPersonList();

  @override
  List<Object> get props => [];
}

class GetPersonDetails extends PersonDataEvent {
  final String id;

  const GetPersonDetails({required this.id});

  @override
  List<Object> get props => [id];
}
