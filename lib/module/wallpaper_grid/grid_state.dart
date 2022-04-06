part of 'grid_bloc.dart';

@immutable
abstract class GridState {}

class GridInitial extends GridState {
  bool isLoading = true;
}

class GridLoaded extends GridState {}

class GridLoading extends GridState {}

class GridError extends GridState {}
