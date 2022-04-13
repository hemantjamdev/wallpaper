import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/module/wallpaper_grid/grid_bloc.dart';

Widget searchBar(TextEditingController controller, BuildContext context) {
  void search(String text) {
    BlocProvider.of<GridBloc>(context).add(GetCategoryEvent(name: text));
  }

  return Padding(
    padding: const EdgeInsets.all(5.0),
    child: Card(
      child: TextFormField(
        onFieldSubmitted: (value) {
          search(value);
        },
        autofocus: false,
        textInputAction: TextInputAction.search,
        controller: controller,
        decoration: InputDecoration(
          hintText: 'search wallpaper',
          suffixIcon: IconButton(
            onPressed: () {
              search(controller.text);
            },
            icon: Icon(Icons.search),
          ),
        ),
      ),
    ),
  );
}
