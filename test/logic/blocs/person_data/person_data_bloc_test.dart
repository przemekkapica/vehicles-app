import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:vehicles_app/data/models/person.dart';
import 'package:vehicles_app/data/repositories/mock/person_repository.mocks.dart';
import 'package:vehicles_app/logic/blocs/person_data/person_data_bloc.dart';
import 'package:vehicles_app/logic/blocs/person_data/person_data_event.dart';
import 'package:vehicles_app/logic/blocs/person_data/person_data_state.dart';

class FakePerson extends Fake implements Person {
  FakePerson({required this.id});

  final String id;
}

void main() {
  late PersonDataBloc personDataBloc;
  late MockPersonRepository mockPersonRepository;

  setUp(() {
    mockPersonRepository = MockPersonRepository();
    personDataBloc = PersonDataBloc(personRepository: mockPersonRepository);
  });

  tearDown(() {
    personDataBloc.close();
  });

  group('PersonDataBloc test', () {
    test('Checks initial state', () async {
      expectLater(personDataBloc.state, PersonListEmpty());
    });

    blocTest(
      'Gets persons list unsuccessfully',
      build: () {
        when(mockPersonRepository.getPersonList()).thenThrow(PersonListError());
        return PersonDataBloc(personRepository: mockPersonRepository);
      },
      act: (PersonDataBloc bloc) => bloc.add(GetPersonList()),
      expect: () => [
        PersonListLoading(),
        PersonListError(),
      ],
    );

    List<Person> emptyPersonList = [];
    blocTest(
      'Gets persons list successfully',
      build: () {
        when(mockPersonRepository.getPersonList())
            .thenAnswer((_) async => Future<List<Person>>.value(<Person>[]));
        return PersonDataBloc(personRepository: mockPersonRepository);
      },
      act: (PersonDataBloc bloc) => bloc.add(GetPersonList()),
      expect: () => [
        PersonListLoading(),
        PersonListLoaded(personList: emptyPersonList),
      ],
    );

    blocTest(
      'Gets person details unsuccessfully',
      build: () {
        when(mockPersonRepository.getPersonDetails('id'))
            .thenThrow(PersonListError());
        return PersonDataBloc(personRepository: mockPersonRepository);
      },
      act: (PersonDataBloc bloc) => bloc.add(GetPersonDetails(id: 'id')),
      expect: () => [
        PersonDetailsLoading(),
        PersonDetailsError(),
      ],
    );

    blocTest(
      'Gets person details successfully',
      build: () {
        when(mockPersonRepository.getPersonDetails('id')).thenAnswer(
            (_) async => Future<Person>.value(FakePerson(id: 'id')));
        return PersonDataBloc(personRepository: mockPersonRepository);
      },
      act: (PersonDataBloc bloc) => bloc.add(GetPersonDetails(id: 'id')),
      expect: () => [
        PersonDetailsLoading(),
        isA<PersonDetailsLoaded>(),
      ],
    );
  });
}
