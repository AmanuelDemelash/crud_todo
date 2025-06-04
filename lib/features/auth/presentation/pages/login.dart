import 'package:crud_todo/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:crud_todo/features/auth/presentation/pages/sign_up.dart';
import 'package:crud_todo/features/home/presentation/pages/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late final TextEditingController _emailController = TextEditingController();
  late final TextEditingController _passwordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign In')),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            context.showSnackBar(state.message, isError: true);
          } else if (state is AuthSuccess) {
            if (mounted) {
              context.showSnackBar('Login successful!');
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => Home()),
              );
            }
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 18),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "email is empity";
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Password'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password is empity";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: state is AuthLoading
                        ? null
                        : () {
                            if (_formKey.currentState!.validate()) {
                              context.read<AuthBloc>().add(
                                    LoginEvent(
                                      email: _emailController.text.trim(),
                                      password: _passwordController.text.trim(),
                                    ),
                                  );
                            }
                          },
                    child: state is AuthLoading
                        ? CupertinoActivityIndicator()
                        : Text(
                            'Login',
                            style: TextStyle(color: Colors.white),
                          ),
                  ),
                  const SizedBox(height: 18),
                  Text("OR"),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                          builder: (context) => const AccountPage()),
                    ),
                    child: Text(
                      'SignUp',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
