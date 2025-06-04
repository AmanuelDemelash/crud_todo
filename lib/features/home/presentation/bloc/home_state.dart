part of 'home_bloc.dart';

class HomeState extends Equatable {
  const HomeState(this.todos);
  final List<Todo> todos;

  HomeState copyWith({
    List<Todo>? todos,
  }) {
    return HomeState(
      todos ?? this.todos,
    );
  }

  @override
  List<Object> get props => [todos];
}

class HomeInitial extends HomeState {
  HomeInitial(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class UpdateTodosLoading extends HomeState {
  UpdateTodosLoading(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class UpdateTodosLoaded extends HomeState {
  UpdateTodosLoaded(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class TodosLoading extends HomeState {
  TodosLoading(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class AddTodosLoading extends HomeState {
  AddTodosLoading(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class DeleteTodosLoading extends HomeState {
  DeleteTodosLoading(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class DeletedTodos extends HomeState {
  DeletedTodos(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class AddTodosLoaded extends HomeState {
  AddTodosLoaded(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class TodosLoaded extends HomeState {
  TodosLoaded(HomeState currentState)
      : super(
          currentState.todos,
        );
}

class TodoFailure extends HomeState {
  final String message;
  TodoFailure(HomeState currentState, {required this.message})
      : super(
          currentState.todos,
        );

  @override
  List<Object> get props => [message];
}
