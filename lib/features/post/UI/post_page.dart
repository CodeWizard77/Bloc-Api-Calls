import 'package:bloc_api_requests/features/post/bloc/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc postBloc = PostBloc();
  @override
  void initState() {
    super.initState();
    postBloc.add(PostInitialFetchEvent());
  }

  @override
  Widget build(BuildContext context) {
    //final PostBloc postBloc = BlocProvider.of<PostBloc>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text("Post Page"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            postBloc.add(PostAddEvent());
          },
          child: const Icon(Icons.add),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BlocConsumer<PostBloc, PostState>(
              bloc: postBloc,
              listenWhen: (previous, current) => current is PostActionState,
              buildWhen: (previous, current) => current is! PostActionState,
              listener: (context, state) {},
              builder: (context, state) {
                switch (state.runtimeType) {
                  case PostFetchLoadingState:
                    return const Center(
                      child: CircularProgressIndicator(),
                    );

                  case PostFetchSuccessfulState:
                    final successState = state as PostFetchSuccessfulState;
                    return Expanded(
                      child: ListView.builder(
                        itemCount: successState.posts.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.grey[300],
                                  borderRadius: BorderRadius.circular(15)),
                              child: ListTile(
                                titleAlignment: ListTileTitleAlignment.top,
                                title: Text(
                                    successState.posts[index].title.toString()),
                                subtitle: Text(
                                    successState.posts[index].body.toString()),
                              ),
                            ),
                          );
                        },
                      ),
                    );

                  default:
                }
                return Container();
              },
            )
          ],
        ));
  }
}
