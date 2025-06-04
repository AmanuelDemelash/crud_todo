import 'package:crud_todo/features/home/presentation/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/presentation/pages/login.dart';
import 'features/home/presentation/bloc/home_bloc.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: 'https://riiegqyofdxaximyjiqj.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJpaWVncXlvZmR4YXhpbXlqaXFqIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NDkwMzcyMzksImV4cCI6MjA2NDYxMzIzOX0.tGE2LjGzuqWLXoMSuNUkrk67cO6y0snmwLdQ5bcHqWY',
  );
  runApp(const MyApp());
}

final supabase = Supabase.instance.client;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc(),
        ),
        BlocProvider<HomeBloc>(
          create: (context) => HomeBloc(),
        ),
      ],
      child: MaterialApp(
        title: 'Crud',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.light(
            primary: Colors.blue,
            secondary: Colors.blueAccent,
          ),
          snackBarTheme: SnackBarThemeData(
            backgroundColor: Colors.blueGrey,
            contentTextStyle: TextStyle(color: Colors.white),
          ),
        ),
        home: supabase.auth.currentSession == null ? LoginPage() : Home(),
      ),
    );
  }
}

extension ContextExtension on BuildContext {
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError
            ? Theme.of(this).colorScheme.error
            : Theme.of(this).snackBarTheme.backgroundColor,
      ),
    );
  }
}
