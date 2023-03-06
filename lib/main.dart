import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_drag_drop/ui/theme/app_theme_light.dart';

import 'bloc/drag/drag_bloc.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<DragBloc>(
          create: (BuildContext context) => DragBloc(),
        ),
      ],
      child: Builder(builder: (context) => MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: AppThemeLight().theme,
          home: HomeScreen()
      )),
    );
  }
}
