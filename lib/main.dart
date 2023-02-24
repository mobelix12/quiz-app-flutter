import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz_app/assets/colors.dart';
import 'package:quizz_app/featrures/auth/bloc/auth_bloc.dart';
import 'package:quizz_app/featrures/auth/screens/LoginScreen.dart';
import 'package:quizz_app/featrures/auth/screens/SignupScreen.dart';
import 'package:quizz_app/featrures/categories/bloc/categories_bloc.dart';
import 'package:quizz_app/featrures/categories/screens/TopicsListScreen.dart';
import 'package:quizz_app/featrures/leaderboard/bloc/leaderboard_bloc.dart';
import 'package:quizz_app/featrures/quizzes/bloc/quizzes_bloc.dart';
import 'package:quizz_app/featrures/repositories/auth_repo.dart';
import 'package:quizz_app/featrures/repositories/categories_repo.dart';
import 'package:quizz_app/featrures/repositories/leaderboard_repo.dart';
import 'package:quizz_app/featrures/repositories/quizzes_repo.dart';
import 'package:quizz_app/featrures/user/screens/BottomTabsNavigation.dart';
import 'featrures/auth/screens/InitialScreen.dart';
import './featrures/quizzes/screens/CountSelection.dart';
import 'featrures/quizzes/models/quiz.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authRepository = AuthRepo();
    final categoriesRepository = CategoriesRepo();
    final quizzesRepository = QuizzesRepo();
    final leaderboardRepo = LeaderboardRepo();

    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) =>
                AuthBloc(authRepo: authRepository)),
        BlocProvider(
            create: (BuildContext context) =>
                CategoriesBloc(categoriesRepo: categoriesRepository)),
        BlocProvider(
            create: (BuildContext context) =>
                QuizzesBloc(quizzesRepo: quizzesRepository)),
        BlocProvider(
            create: (BuildContext context) =>
                LeaderboardBloc(leaderboardRepo: leaderboardRepo)),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        initialRoute: '/initial',
        routes: {
          '/initial': (context) => const InitialScreen(),
          '/login_screen': (context) => const LoginScreen(),
          '/registration_screen': (context) => const SignupScreen(),
          '/main_screen': (context) => const BottomTabs(),
          '/main_screen/topics_list_screen': (context) =>
              const TopicsListScreen(),
          '/main_screen/count_selection': (context) {
            final args = ModalRoute.of(context)!.settings.arguments as Topic;
            return CountSelection(
              topic: args,
            );
          },
        },
        theme: ThemeData(scaffoldBackgroundColor: ColorConstants.violet),
      ),
    );
  }
}
