import 'package:flutter/material.dart';
import 'package:pro/component/shared_pref.dart';
import 'package:pro/layouts/home_layout.dart';
import 'package:pro/modules/archivedTasks/archive_screen.dart';
import 'package:pro/modules/doneTasks/done_tasks_screen.dart';
import 'package:pro/modules/login_and_register/login_page.dart';
import 'package:pro/modules/login_and_register/sign_up_page.dart';
import 'package:pro/modules/newTasks/new_tasks_screen.dart';
import 'package:pro/modules/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
          future: SharedPreferencesHelper.getLoginState(),
          builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              return HomeLayout();
            } else {
              return LoginPage();
            }
          }
        },
          ),
      routes: {
        SplashScreen.routeName: (_) => const SplashScreen(),
        LoginPage.routeName: (_) => LoginPage(),
        SignUpPage.routeName: (_) => SignUpPage(),
        HomeLayout.routeName: (_) => HomeLayout(),
        NewTaskScreen.routeName: (_) => const NewTaskScreen(),
        DoneTaskScreen.routeName: (_) => const DoneTaskScreen(),
        ArchivedTaskScreen.routeName: (_) => const ArchivedTaskScreen(),
      },
      initialRoute: SplashScreen.routeName,
    );
  }
}
