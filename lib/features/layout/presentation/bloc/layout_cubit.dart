import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:tasks/core/utils/logging/logger.dart';
import 'package:tasks/features/archived/presentation/screen/archived.dart';
import 'package:tasks/features/done/presentation/screen/done.dart';
import 'package:tasks/features/layout/presentation/bloc/layout_state.dart';
import 'package:tasks/features/tasks/presentation/screen/tasks.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitialState());

  static LayoutCubit get(context) => BlocProvider.of(context);

  // Variable
  final TextEditingController titleController = TextEditingController();
  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Database constants
  static const String _databaseName = 'task.db';
  static const int _databaseVersion = 1;
  static const String _tableName = 'tasks';
  static const String _columnId = 'id';
  static const String _columnTitle = 'title';
  static const String _columnDate = 'date';
  static const String _columnTime = 'time';
  static const String _columnStatus = 'status';

  // Navigation variables
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  final List<Widget> _screens = const [
    TasksScreen(),
    DoneScreen(),
    ArchivedScreen(),
  ];

  final List<String> _screenTitles = const [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];

  // Database instance
  Database? _database;

  Database? get database => _database;

  List<String> get titles => _screenTitles;

  List<Widget> get screens => _screens;

  // Change current screen
  void changeScreen(int index) {
    if (index >= 0 && index < screens.length) {
      _selectedIndex = index;
      emit(BottomNavigationBarState());
    } else {
      LoggerHelper.warning('Invalid screen index: $index');
    }
  }

  // Initialize database
  Future<void> createDatabase() async {
    try {
      _database = await openDatabase(
        _databaseName,
        version: _databaseVersion,
        onCreate: _onCreate,
        onOpen: (db) => LoggerHelper.debug('Database opened'),
      );
      emit(CreateDatabaseSuccessState());
    } catch (e) {
      LoggerHelper.error('Failed to create database: ${e.toString()}');
      emit(
        CreateDatabaseErrorState(
          error: 'Failed to create database: ${e.toString()}',
        ),
      );
    }
  }

  // Database creation callback
  Future<void> _onCreate(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $_tableName (
          $_columnId INTEGER PRIMARY KEY,
          $_columnTitle TEXT,
          $_columnDate TEXT,
          $_columnTime TEXT,
          $_columnStatus TEXT
        )
      ''');
      LoggerHelper.debug('Database and table created successfully');
    } catch (e) {
      LoggerHelper.error('Failed to create table: ${e.toString()}');
      rethrow;
    }
  }

  // Insert data into database
  Future<void> insertToDatabase({
    required String title,
    required String date,
    required String time,
    required String status,
  }) async {
    if (_database == null) {
      LoggerHelper.warning('Database not initialized');
      return;
    }
    try {
      final id = await _database!.rawInsert(
        '''
        INSERT INTO $_tableName(
          $_columnTitle, 
          $_columnDate, 
          $_columnTime, 
          $_columnStatus
        ) VALUES (?, ?, ?, ?)
      ''',
        [title, date, time, status],
      );

      LoggerHelper.debug('Inserted record with id: $id');
      emit(InsertDatabaseSuccessState());
    } catch (e) {
      LoggerHelper.error('Failed to insert record: ${e.toString()}');
      emit(InsertDatabaseErrorState(error: e.toString()));
    }
  }

  // Get data from database
  Future<List<Map<String, dynamic>>> getDataFromDatabase() async {
    if (_database == null) {
      LoggerHelper.warning('Database not initialized');
      return [];
    }
    try {
      final result = await _database!.query(_tableName);
      print(result);
      return result;
    } catch (e) {
      LoggerHelper.error('Failed to get data from database: ${e.toString()}');
      return [];
    }
  }

  // Update data in database
  Future<void> updateDatabase(Map<String, dynamic> data) async {
    if (_database == null) {
      LoggerHelper.warning('Database not initialized');
      return;
    }
    try {
      await _database!.update(
        _tableName,
        data,
        where: '$_columnId = ?',
        whereArgs: [data[_columnId]],
      );
      LoggerHelper.debug('Record updated successfully');
    } catch (e) {
      LoggerHelper.error('Failed to update record: ${e.toString()}');
    }
  }

  // Delete data from database
  Future<void> deleteFromDatabase(int id) async {
    if (_database == null) {
      LoggerHelper.warning('Database not initialized');
      return;
    }
    try {
      await _database!.delete(
        _tableName,
        where: '$_columnId = ?',
        whereArgs: [id],
      );
      LoggerHelper.debug('Record deleted successfully');
    } catch (e) {
      LoggerHelper.error('Failed to delete record: ${e.toString()}');
    }
  }

  // Change bottom sheet state
  bool _isBottomSheetShown = false;
  bool get isBottomSheetShown => _isBottomSheetShown;
  void changeBottomSheetState({required bool isShow}) {
    _isBottomSheetShown = isShow;
    emit(ChangeBottomSheetState(isShow: isShow));
  }

  // Close database
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // Dispose method
  @override
  Future<void> close() async {
    await closeDatabase();
    return super.close();
  }
}
