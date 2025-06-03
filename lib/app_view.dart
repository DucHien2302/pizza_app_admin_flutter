import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'src/blocs/authentication_bloc/authentication_bloc.dart';
import 'src/routes/routes.dart';

class MyAppView extends StatefulWidget {
  const MyAppView({super.key});

  @override
  State<MyAppView> createState() => _MyAppViewState();
}

class _MyAppViewState extends State<MyAppView> {
  late final GoRouter _router;
  
  @override
  void initState() {
    super.initState();
    _router = router(context.read<AuthenticationBloc>());
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Pizza Admin",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          onBackground: Colors.black,
          primary: Colors.blue,
          onPrimary: Colors.white,
        ),
      ),
      routerConfig: _router,
    );
  }
}