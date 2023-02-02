import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/assets/colors.dart';
import 'package:quizz_app/featrures/auth/cubit/auth_cubit.dart';
import 'featrures/auth/screens/InitialScreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(),
      child: MaterialApp(
        title: 'Flutter Demo',
        home: Navigator(
          pages: const [MaterialPage(child: InitialScreen())],
          onPopPage: (route, result) {
            return route.didPop(result);
          },
        ),
        theme: ThemeData(scaffoldBackgroundColor: ColorConstants.violet),
      ),
    );
  }
}
