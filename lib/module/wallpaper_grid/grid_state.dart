part of 'grid_bloc.dart';

@immutable
abstract class GridState {}

class GridInitial extends GridState {}

class GridLoaded extends GridState {
  final ImageModel imageModel;

  GridLoaded({required this.imageModel});
}



class GridLoading extends GridState {}

class GridError extends GridState {
  final String errorText;

  GridError({required this.errorText});
}
