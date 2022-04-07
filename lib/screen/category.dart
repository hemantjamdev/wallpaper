import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wallpaper/module/wallpaper_grid/grid_bloc.dart';

class Category extends StatefulWidget {
  const Category({Key? key}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  int isSelected = 0;
  List<String> categoryList = [
    'All',
    'cars',
    'bike',
    'wallpaper',
    'men',
    'woman',
    'child',
    '3D',
    '4k',
    'dark'
  ];

  void searchCategory(String name) {
    BlocProvider.of<GridBloc>(context).add(GetCategoryEvent(name: name));
  }

  @override
  Widget build(BuildContext context) {
    return buildContainer(context);
  }

  Widget buildContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      child: Center(
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoryList.length,
            itemBuilder: (context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    isSelected = index;
                  });
                  searchCategory(categoryList[index]);
                },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        color: index == isSelected ? Colors.orangeAccent : null,
                        border: Border.all(color: Colors.black, width: 2),
                        borderRadius: BorderRadius.circular(25)),
                    child: Center(child: Text(categoryList[index]))),
              );
            }),
      ),
    );
  }
}
