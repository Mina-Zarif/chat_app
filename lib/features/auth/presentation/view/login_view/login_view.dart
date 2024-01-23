import 'package:chat_app/features/auth/presentation/mange/login_cubit/login_cubit.dart';
import 'package:chat_app/features/auth/presentation/view/signup_view/signup_view.dart';
import 'package:chat_app/features/home/presentation/view/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: BlocProvider(
        create: (context) => LoginCubit(),
        child: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Login Successfully")));
            }
            if (state is UnauthenticatedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
          },
          builder: (context, state) {
            final LoginCubit cubit = BlocProvider.of(context);
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextField(
                    controller: cubit.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextField(
                    controller: cubit.passwordController,
                    obscureText: false,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () => cubit.login(
                      onSuccess: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      ),
                    ),
                    child: const Text('Login'),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupView(),
                        ),
                      );
                    },
                    child: const Text("if u haven't one signup"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
