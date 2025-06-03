import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'app_view.dart';
import 'src/blocs/authentication_bloc/authentication_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create a singleton repository
    final userRepository = FirebaseUserRepo();
    
    return BlocProvider(
      create: (_) => AuthenticationBloc(
        userRepository: userRepository,
      ),
      child: const MyAppView(),
    );
  }
}
