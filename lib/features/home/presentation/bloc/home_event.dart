part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class LoadTodosEvent extends HomeEvent {
  const LoadTodosEvent();

  @override
  List<Object> get props => [];
}

class AddTodoEvent extends HomeEvent {
  final String title;
  final String description;

  const AddTodoEvent({required this.title, required this.description});

  @override
  List<Object> get props => [title, description];
}

class DeleteTodoEvent extends HomeEvent {
  final int id;

  const DeleteTodoEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class UpdateTodoEvent extends HomeEvent {
  final int id;
  final String title;
  final String description;

  const UpdateTodoEvent({
    required this.id,
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [id, title, description];
}
