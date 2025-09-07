import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spendo/core/bloc/bloc/user_bloc.dart';
import 'package:spendo/core/repository/firebase.dart';
import 'package:spendo/screen/main_navigator.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(create: (context) => FirebaseRepository()),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<UserBloc>(
            create:
                (BuildContext context) => UserBloc(
                  RepositoryProvider.of<FirebaseRepository>(context),
                ),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          debugShowCheckedModeBanner: false,
          home: const MainNavigator(),
        ),
      ),
    );
  }
}
