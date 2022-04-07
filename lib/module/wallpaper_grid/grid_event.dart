part of 'grid_bloc.dart';

@immutable
abstract class GridEvent {}

class GetDataEvent extends GridEvent {
  final String name;
  GetDataEvent({required this.name});
}

class GetCategoryEvent extends GridEvent {
  final String name;

  GetCategoryEvent({required this.name});
}
