import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pro/cubit/cubit.dart';
import 'package:pro/cubit/states.dart';
import 'package:pro/widgets/shared.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  HomeLayout({super.key});
  static String routeName = 'home';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppState>(
        listener: (BuildContext context, AppState state) {
          if (state is AppInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context, AppState state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              centerTitle: true,
              elevation: 0,
              title: Text(
                cubit.title[cubit.currentIndex],
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            body: state is AppGetDatabaseLoadingState
                ? const Center(child: CircularProgressIndicator())
                : cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState!.validate()) {
                    cubit.insertDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                    //   insertDatabase(
                    //           title: titleController.text,
                    //           time: timeController.text,
                    //           date: dateController.text)
                    //       .then((value) {
                    //     getDataFromDatabase(database).then(
                    //       (value) {
                    //         Navigator.pop(context);

                    // setState(
                    //   () {
                    //     isBottomSheetShown = false;
                    //     fabIcon = Icons.edit;
                    //     tasks = value;
                    //     print(tasks);
                    //   },
                    // );
                    //       },
                    //     );
                    //   });
                  }
                } else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          color: Colors.white,
                          padding: const EdgeInsets.all(20.0),
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defaultFormField(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                    return null;
                                  },
                                  lable: ' Task Title',
                                  prefix: Icons.title,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now())
                                        .then(
                                      (value) {
                                        timeController.text =
                                            value!.format(context).toString();
                                        print(value.format(context));
                                      },
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                    return null;
                                  },
                                  lable: ' Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                const SizedBox(
                                  height: 15.0,
                                ),
                                defaultFormField(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2024-05-25'),
                                    ).then(
                                      (value) {
                                        dateController.text =
                                            DateFormat.yMMMd().format(value!);
                                      },
                                    );
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Date must not be empty';
                                    }
                                    return null;
                                  },
                                  lable: ' Task Date',
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 20,
                      )
                      .closed
                      .then((value) {
                    cubit.changeBottomSheetState(
                        isShow: false, icon: Icons.edit);
                  });
                  cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
                }
              },
              backgroundColor:kPrimaryColor,
              child: Icon(
                cubit.fabIcon,
                color: Colors.white,
              ),
            ),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor:kPrimaryColor,
              type: BottomNavigationBarType.fixed,
              currentIndex: cubit.currentIndex,
              selectedItemColor: Colors.white,
              onTap: (index) {
                cubit.changeIndex(index);
              },
              iconSize: 30,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.check_circle_outline), label: 'Done'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined), label: 'Archive'),
              ],
            ),
          );
        },
      ),
    );
  }
}
