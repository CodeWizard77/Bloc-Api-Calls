import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:bloc_api_requests/features/post/model/post_model.dart';
import 'package:bloc_api_requests/features/post/repos/post_repo.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialEvent);
    on<PostAddEvent>(postAddEvent);
  }

  Future<FutureOr<void>> postInitialEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    emit(PostFetchLoadingState());

    List<PostModel> posts = await PostRepo.fetchApi();
    emit(PostFetchSuccessfulState(posts: posts));
  }

  FutureOr<void> postAddEvent(
      PostAddEvent event, Emitter<PostState> emit) async {
    bool success = await PostRepo.addPost();
    print(success);
    if (success) {
      emit(PostAddSuccessState());
    } else {
      emit(PostAddErrorState());
    }
  }
}
