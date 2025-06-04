import 'package:crud_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:crud_todo/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/pages/login.dart';
import '../bloc/home_bloc.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<HomeBloc>().add(LoadTodosEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LogOutLoading) {
            } else if (state is LogOutSuccess) {
              context.showSnackBar(
                'Logout successful!',
              );
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()));
            }
          },
        ),
      ],
      child: Scaffold(
          appBar: AppBar(
            title: const Text('MyTodo'),
            actions: [
              IconButton(
                  onPressed: () async {
                    context.read<AuthBloc>().add(LogoutEvent());
                  },
                  icon: Icon(Icons.logout))
            ],
          ),
          body: Column(
            children: [
              const SizedBox(height: 18),
              const Center(
                child: Text(
                  'Welcome to MyTodo',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 18),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor),
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: false,
                    builder: (context) => BlocConsumer<HomeBloc, HomeState>(
                      listener: (context, state) {
                        if (state is AddTodosLoaded) {
                          Navigator.pop(context);
                          context.showSnackBar('Todo added successfully!');
                          _titleController.clear();
                          _descriptionController.clear();
                          context.read<HomeBloc>().add(LoadTodosEvent());
                        } else if (state is TodoFailure) {
                          context.showSnackBar(state.message, isError: true);
                        }
                      },
                      builder: (context, state) {
                        return Container(
                          height: MediaQuery.of(context).size.height,
                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          padding: EdgeInsets.all(16),
                          child: SingleChildScrollView(
                            child: Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  const SizedBox(height: 18),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _titleController,
                                    decoration: const InputDecoration(
                                      labelText: 'Todo Title',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "title is empity";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  TextFormField(
                                    autovalidateMode:
                                        AutovalidateMode.onUserInteraction,
                                    controller: _descriptionController,
                                    decoration: const InputDecoration(
                                      labelText: 'Todo Description',
                                    ),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "description is empity";
                                      }
                                      return null;
                                    },
                                  ),
                                  const SizedBox(height: 18),
                                  ElevatedButton(
                                    onPressed: state is AddTodosLoading
                                        ? () {}
                                        : () {
                                            if (_formKey.currentState!
                                                .validate()) {
                                              context.read<HomeBloc>().add(
                                                    AddTodoEvent(
                                                      title:
                                                          _titleController.text,
                                                      description:
                                                          _descriptionController
                                                              .text,
                                                    ),
                                                  );
                                            }
                                          },
                                    child: state is AddTodosLoading
                                        ? CircularProgressIndicator()
                                        : const Text('Add Todo'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
                child: const Text(
                  'Add Todo',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Expanded(
                  child: BlocConsumer<HomeBloc, HomeState>(
                listener: (context, state) {
                  if (state is TodoFailure) {
                    context.showSnackBar(state.message, isError: true);
                  }
                },
                builder: (context, state) {
                  if (state is TodosLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is TodoFailure) {
                    return Center(child: Text(state.message));
                  }
                  return state.todos.isEmpty
                      ? Center(
                          child: Text("No todo yet!"),
                        )
                      : ListView.builder(
                          itemCount: state.todos.length,
                          itemBuilder: (context, index) {
                            final todo = state.todos[index];
                            return Container(
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey.withValues(alpha: 0.2)),
                              child: ListTile(
                                onTap: () {
                                  _titleController.text = todo.title;
                                  _descriptionController.text =
                                      todo.description;
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) =>
                                        BlocConsumer<HomeBloc, HomeState>(
                                      listener: (context, state) {
                                        if (state is UpdateTodosLoaded) {
                                          Navigator.pop(context);
                                          context.showSnackBar(
                                              'Todo update successfully!');
                                          _titleController.clear();
                                          _descriptionController.clear();
                                          context
                                              .read<HomeBloc>()
                                              .add(LoadTodosEvent());
                                        } else if (state is TodoFailure) {
                                          context.showSnackBar(state.message,
                                              isError: true);
                                        }
                                      },
                                      builder: (context, state) {
                                        return Container(
                                          height: MediaQuery.of(context)
                                              .size
                                              .height,
                                          margin: EdgeInsets.only(
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom,
                                          ),
                                          padding: EdgeInsets.all(16),
                                          child: SingleChildScrollView(
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 18),
                                                TextFormField(
                                                  controller: _titleController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'Todo Title',
                                                  ),
                                                ),
                                                const SizedBox(height: 18),
                                                TextFormField(
                                                  controller:
                                                      _descriptionController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText:
                                                        'Todo Description',
                                                  ),
                                                ),
                                                const SizedBox(height: 18),
                                                ElevatedButton(
                                                  onPressed: state
                                                          is UpdateTodosLoading
                                                      ? () {}
                                                      : () {
                                                          context
                                                              .read<HomeBloc>()
                                                              .add(
                                                                UpdateTodoEvent(
                                                                  id: todo.id,
                                                                  title:
                                                                      _titleController
                                                                          .text,
                                                                  description:
                                                                      _descriptionController
                                                                          .text,
                                                                ),
                                                              );
                                                        },
                                                  child: state
                                                          is UpdateTodosLoading
                                                      ? CircularProgressIndicator()
                                                      : const Text('Update'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                                title: Text(todo.title),
                                subtitle: Text(todo.description),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    // Handle delete action
                                    context.read<HomeBloc>().add(
                                          DeleteTodoEvent(id: todo.id),
                                        );
                                  },
                                ),
                              ),
                            );
                          },
                        );
                },
              )),
            ],
          )),
    );
  }
}
