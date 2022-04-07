import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:wallpaper/model/image_model.dart';
import 'package:wallpaper/module/wallpaper_grid/repo.dart';

part 'grid_event.dart';

part 'grid_state.dart';

class GridBloc extends Bloc<GridEvent, GridState> {
  Repo repo = Repo();

  GridBloc() : super(GridInitial()) {
    on<GridEvent>((event, emit) async {
      if (event is GetDataEvent) {
        emit(GridLoading());
        var data = await repo.getData(category: event.name);
        if (data != null) {
          emit(GridLoaded(imageModel: data));
        } else {
          emit(GridError(errorText: 'something went wrong'));
        }
      } else if (event is GetCategoryEvent) {
        emit(GridLoading());

        var data = await repo.getData(category: event.name);
        if (data != null) {
          emit(GridLoaded(imageModel: data));
        } else {
          emit(GridError(errorText: 'something went wrong'));
        }
      }
    });
  }
}
