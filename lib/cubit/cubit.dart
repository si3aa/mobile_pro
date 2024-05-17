import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pro/cubit/states.dart';
import 'package:pro/modules/archivedTasks/archive_screen.dart';
import 'package:pro/modules/doneTasks/done_tasks_screen.dart';
import 'package:pro/modules/newTasks/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppIntialState());
  static AppCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTaskScreen(),
    const DoneTaskScreen(),
    const ArchivedTaskScreen()
  ];
  List<String> title = ['NewTasks', 'DoneTasks', 'ArchivedTasks'];

  void changeIndex(int index) {
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }

  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  var database;
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT,date TEXT,time TEXT,status TEXT)')
            .then(
          (value) {
            print('table created');
          },
        ).catchError((Error) {
          print('Error when create Table ${Error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabase(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
    await database.transaction((txn) async {
      await txn
          .rawInsert(
              'INSERT INTO tasks(title,date,time,status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted successfuly');
        emit(AppInsertDatabaseState());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when Inserting new record ${error.toString()}');
      });
       return newTasks;
    });
  }

  void getDataFromDatabase(database) {
    newTasks = [];
    doneTasks = [];
    archiveTasks = [];
    emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach(
        (element) {
          if (element['status'] == 'new') {
            newTasks.add(element);
          } else if (element['status'] == 'done') {
            doneTasks.add(element);
          } else {
            archiveTasks.add(element);
          }
        },
      );

      emit(AppGetDatabaseState());
    });
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void changeBottomSheetState({required bool isShow, required IconData icon}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(AppChangeBottomSheetState());
  }

  void update({
    required String status,
    required int id,
  }) {
    database.rawUpdate(
        'UPDATE tasks SET status = ? WHERE id =?', [status, id]).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDatabaseState());
    });
  }

  void delete({
    required int id,
  }) {
    database.rawDelete('DELETE FROM tasks WHERE id =?', [id]).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDatabaseState());
    });
  }
}
