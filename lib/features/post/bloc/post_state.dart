part of 'post_bloc.dart';

@immutable
sealed class PostState {}

abstract class PostActionState extends PostState {}

final class PostInitial extends PostState {}

class PostFetchLoadingState extends PostState {}

class PostFetchErrorState extends PostState {}

class PostFetchSuccessfulState extends PostState {
  final List<PostModel> posts;

  PostFetchSuccessfulState({required this.posts});
}

class PostAddSuccessState extends PostActionState {}

class PostAddErrorState extends PostActionState {}
