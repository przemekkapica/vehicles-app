import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vehicles_app/logic/blocs/person_data/bloc.dart';
import 'package:vehicles_app/data/models/person.dart';
import 'package:vehicles_app/data/repositories/person_repository.dart';

class PersonDataBloc extends Bloc<PersonDataEvent, PersonDataState> {
  final PersonRepository personRepository;

  PersonDataBloc({required this.personRepository}) : super(PersonListEmpty());

  PersonDataState get initialState => PersonListEmpty();

  Future<void> getPersonList() async {
    final List<Person> personList = await personRepository.getPersonList();
    emit(PersonListLoaded(personList: personList));
  }

  Future<void> getOwnerDetails(String id) async {
    final Person person = await personRepository.getPersonDetails(id);
    emit(PersonDetailsLoaded(person: person));
  }

  @override
  Stream<PersonDataState> mapEventToState(PersonDataEvent event) async* {
    if (event is GetPersonList) {
      yield PersonListLoading();
      try {
        final List<Person> personList = await personRepository.getPersonList();
        yield PersonListLoaded(personList: personList);
      } catch (_) {
        yield PersonListError();
      }
    }

    if (event is GetPersonDetails) {
      yield PersonDetailsLoading();
      try {
        final Person person = await personRepository.getPersonDetails(event.id);
        if (person.id == 'not_found') {
          yield PersonDetailsNotFound();
        } else {
          yield PersonDetailsLoaded(person: person);
        }
      } catch (_) {
        yield PersonDetailsError();
      }
    }
  }
}
