import 'package:equatable/equatable.dart';
import 'package:vehicles_app/data/models/models.dart';

abstract class CarDataState extends Equatable {
  const CarDataState();

  @override
  List<Object> get props => [];
}

class CarListEmpty extends CarDataState {}

class CarListLoading extends CarDataState {}

class CarListLoaded extends CarDataState {
  final List<Car> carList;

  const CarListLoaded({required this.carList});

  @override
  List<Object> get props => [carList];
}

class CarListError extends CarDataState {}
