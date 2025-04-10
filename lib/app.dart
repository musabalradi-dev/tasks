import 'package:flutter/material.dart';
import 'package:tasks/core/theme/theme.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_cubit.dart';
import 'package:tasks/features/layout/presentation/screen/layout.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: ThemeApp.lightTheme,
      darkTheme: ThemeApp.darkTheme,
      home: BlocProvider(
          create: (context) => LayoutCubit()..createDatabase(),
          child: const LayoutScreen()),
      locale: Locale('en', 'US'),
    );
  }
}
