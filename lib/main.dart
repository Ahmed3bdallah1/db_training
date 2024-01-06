import 'package:db/core/controllers/cubit/db_cubit.dart';
import 'package:db/core/controllers/provider/database_provider.dart';
import 'package:db/screens/modules/cubit_modules/notes_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

void main() {
  Provider.debugCheckInvalidValueType = null;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(
          create: (context) => DbCubit()..createDatabase(),
          lazy: false,
        ),
        Provider(
          create: (context) => DatabaseProvider()..createDatabase(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const NotesScreen(),
      ),
    );
  }
}
