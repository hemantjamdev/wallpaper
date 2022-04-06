import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'grid_event.dart';

part 'grid_state.dart';

class GridBloc extends Bloc<GridEvent, GridState> {
  GridBloc() : super(GridInitial()) {
    on<GridEvent>((event, emit) {
      if (event is GetData) {
        emit();
      }
    });
  }
}
