import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'image_details_event.dart';
part 'image_details_state.dart';

class ImageDetailsBloc extends Bloc<ImageDetailsEvent, ImageDetailsState> {
  ImageDetailsBloc() : super(ImageDetailsInitial()) {
    on<ImageDetailsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
