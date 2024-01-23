import 'package:chat_app/features/auth/presentation/mange/signup_cubit/signup_cubit.dart';
import 'package:chat_app/features/auth/presentation/view/login_view/login_view.dart';
import 'package:chat_app/features/home/presentation/view/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: BlocProvider(
        create: (context) => SignupCubit(),
        child: BlocConsumer<SignupCubit, SignupState>(
          listener: (context, state) {
            if (state is AuthenticatedState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Sign Up Successfully")));
            }
            if (state is UnauthenticatedState) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.errorMsg)));
            }
          },
          builder: (context, state) {
            final SignupCubit cubit = BlocProvider.of(context);
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
                      labelText: 'Set Password',
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () => cubit.signup(
                      onSuccess: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeView(),
                        ),
                      ),
                    ),
                    child: const Text('Signup'),
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginView(),
                        ),
                      );
                    },
                    child: const Text('if u have one login'),
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
