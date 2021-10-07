import 'package:equatable/equatable.dart';

abstract class CarDataEvent extends Equatable {
  const CarDataEvent();
}

class GetCarList extends CarDataEvent {
  const GetCarList();

  @override
  List<Object> get props => [];
}
