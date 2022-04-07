import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:wallpaper/module/wallpaper_grid/grid_bloc.dart';
import 'package:wallpaper/widget/imageWidget.dart';

class ImageGrid extends StatefulWidget {
  const ImageGrid({Key? key}) : super(key: key);

  @override
  State<ImageGrid> createState() => _ImageGridState();
}

class _ImageGridState extends State<ImageGrid> {
  final _controller = ScrollController();

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.position.atEdge) {
        bool isTop = _controller.position.pixels == 0;
        if (!isTop) {}
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<GridBloc, GridState>(
        builder: (context, state) {
          if (state is GridInitial) {
            context.read<GridBloc>().add(GetDataEvent(name: 'all'));
            return Center(
                child: Text(
              'loading initial...',
              style: TextStyle(fontSize: 32),
            ));
          } else if (state is GridError) {
            return Center(
              child: Text(
                state.errorText,
                style: TextStyle(fontSize: 32),
              ),
            );
          } else if (state is GridLoaded) {
            return buildStaggeredGrid(state, context);
          } else if (state is GridLoading) {
            return Center(
              child: Text('loading...'),
            );
          } else {
            return Center(child: Text('data not found'));
          }
        },
      ),
    );
  }

  Widget buildStaggeredGrid(GridLoaded state, BuildContext context) {
    return SingleChildScrollView(
      controller: _controller,
      child: StaggeredGrid.count(
        crossAxisCount: 2,
        children: state.imageModel.photos!
            .map((e) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: imageWidget(
                      context: context,
                      thumbNail: e.src!.medium!,
                      url: e.src!.original!,
                      name: e.id.toString()),
                ))
            .toList(),
      ),
    );
  }
}
