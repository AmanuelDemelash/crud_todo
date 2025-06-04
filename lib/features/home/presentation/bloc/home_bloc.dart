import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../main.dart';
import '../../data/models/todo_model.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitial(HomeState([]))) {
    on<LoadTodosEvent>((event, emit) async {
      emit(TodosLoading(state));
      try {
        final response = await supabase.from('todo').select();
        final todos = (response as List)
            .map((item) => Todo.fromJson(item as Map<String, dynamic>))
            .toList();
        emit(state.copyWith(todos: todos));
        // Handle the response as needed
      } catch (error) {
        emit(TodoFailure(state, message: 'Failed to load todos: $error'));
      }
    });

    on<AddTodoEvent>((event, emit) async {
      emit(AddTodosLoading(state));
      try {
        await supabase.from('todo').insert({
          'title': event.title,
          'description': event.description,
        });
        emit(AddTodosLoaded(state));
      } catch (error) {
        emit(TodoFailure(state, message: 'Failed to add todos: $error'));
      }
    });

    on<DeleteTodoEvent>((event, emit) async {
      emit(DeleteTodosLoading(state));
      try {
        await supabase.from('todo').delete().eq('id', event.id);
        final updatedTodos =
            state.todos.where((todo) => todo.id != event.id).toList();
        emit(state.copyWith(todos: updatedTodos));
      } catch (error) {
        emit(TodoFailure(state, message: 'Failed to delete todo: $error'));
      }
    });

    on<UpdateTodoEvent>(
      (event, emit) async {
        emit(UpdateTodosLoading(state));
        try {
          await supabase.from('todo').update({
            'title': event.title,
            'description': event.description,
          }).eq('id', event.id);
          emit(UpdateTodosLoaded(state));
        } catch (error) {
          emit(TodoFailure(state, message: 'Failed to delete todo: $error'));
        }
      },
    );
  }
}
