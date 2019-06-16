import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_infinite_list/bloc/bloc.dart';
import 'package:tutorial_infinite_list/bloc/post.bloc.dart';
import 'package:http/http.dart' as http;
import 'package:tutorial_infinite_list/bloc/post.event.dart';
import 'package:tutorial_infinite_list/widgets/bottom_loader.widget.dart';
import 'package:tutorial_infinite_list/widgets/list_item.widget.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ScrollController _scrollController = ScrollController();
  final PostBloc _postBloc = PostBloc(httpClient: http.Client());
  final double _scrollTrashhold = 200.0;

  _MyHomePageState() {
    _scrollController.addListener(_onScroll);
    _postBloc.dispatch(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _postBloc,
        builder: (BuildContext context, PostState state) {
          if (state is PostUninitalized) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is PostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
              return Center(
                child: Text('no posts'),
              );
            }
            return ListView.builder(
              itemBuilder: (BuildContext context, int index) {
                return index >= state.posts.length
                    ? BottomLoader()
                    : PostWidget(post: state.posts[index]);
              },
              itemCount: state.hasReachedMax
                  ? state.posts.length
                  : state.posts.length + 1,
              controller: _scrollController,
            );
          }
        });
  }

  void _onScroll() {
    final _maxScroll = _scrollController.position.maxScrollExtent;
    final _currentScroll = _scrollController.position.pixels;
    if (_maxScroll - _currentScroll <= _scrollTrashhold) {
      _postBloc.dispatch(Fetch());
    }
  }
}
