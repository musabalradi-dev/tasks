import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/features/archived/presentation/screen/archived.dart';
import 'package:tasks/features/done/presentation/screen/done.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_state.dart';
import 'package:tasks/features/tasks/presentation/screen/tasks.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  // Variable
  int selectedIndex = 0;
  Database? database;
  Logger logger = Logger();
  List<Widget> screen = [TasksScreen(), DoneScreen(), ArchivedScreen()];

  List<String> title = ['New Tasks', 'Done Tasks', 'Archived Tasks'];

  void changeScreen(int index) {
    selectedIndex = index;
    emit(NavigationMenuState());
  }

  void createDataBase() {
    openDatabase(
      'task.db',
      version: 2,
      onCreate: (database, version) {
        print('DataBase Created');
        database.execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title text, date text, time text, status text)',
        );
        print('Table Created');
      },
      onOpen: (database) {
        print('DataBase Opened');
      },
    )
        .then((value) {
      database = value;
      emit(CreateDataBaseState());
    })
        .catchError((error) {
      logger.e('error.toString()');
    });
  }

  void insertToDatabase() {

    database?.transaction((txn) async {
      await txn.rawInsert('INSERT INFO tasks(title, date, time, status) VALUES ("Musab", "dd","dd", "true")').then((value){
        print('$value dfdggdgtgd');
        print('lll');
        emit(InsertDataBaseState());
      }).catchError((error){
        print('object');
      });
      return null;
    }).then((value) {
      print('value');
    }).catchError((error) {
      logger.e(error.toString());
    });
  }
}