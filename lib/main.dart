import 'package:fenix_academia/models/student.dart';
import 'package:fenix_academia/models/user.dart';
import 'package:fenix_academia/models/user_manager.dart';
import 'package:fenix_academia/view/base/base_screen.dart';
import 'package:fenix_academia/view/edit_student/edit_student_screen.dart';
import 'package:fenix_academia/view/exercises/exercises_screen.dart';
import 'package:fenix_academia/view/login/login_screen.dart';
import 'package:fenix_academia/view/money_screen/money_screen.dart';
import 'package:fenix_academia/view/signup/components/signup_confirm.dart';
import 'package:fenix_academia/view/signup/signup_screen.dart';
import 'package:fenix_academia/view/treinning/treinning_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'models/student_manager.dart';
import 'view/student/student_screen.dart';
import 'view/student_list/students_list_screen.dart';
import 'view/suport/suport_screen.dart';

void main() {
  runApp(MyApp());

  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
}

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserManager(),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (_) => StudentManager(),
          lazy: false,
        ),
        Provider(
          create: (_) => SignupConfirm,
          lazy: false,
        ),
      ],
      child: MaterialApp(
        title: 'Academia Fênix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: const Color.fromARGB(255, 80, 30, 30),
//          primaryColor: const Color.fromARGB(255, 46, 52, 65),
          scaffoldBackgroundColor: const Color.fromARGB(255, 80, 30, 30),
//          scaffoldBackgroundColor: const Color.fromARGB(255, 46, 52, 65),
          appBarTheme: const AppBarTheme(elevation: 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        //initialRoute: '/base',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/login':
              return MaterialPageRoute(
                builder: (_) => LoginScreen(),
              );
            case '/signup':
              return MaterialPageRoute(
                builder: (_) => SignupScreen(),
              );
            case '/exercises':
              return MaterialPageRoute(
                builder: (_) => ExercisesScreen(),
              );
            case '/students':
              return MaterialPageRoute(
                builder: (_) => StudentsListScreen(),
              );
            case '/money':
              return MaterialPageRoute(
                builder: (_) => MoneyScreen(),
              );
            case '/treinning':
              return MaterialPageRoute(
                builder: (_) => TreinningScreen(),
              );
            case '/suport':
              return MaterialPageRoute(
                builder: (_) => SuportScreen(),
              );
            case '/student':
              return MaterialPageRoute(
                builder: (_) => StudentScreen(settings.arguments as Student),
              );
            case '/editstudent':
              return MaterialPageRoute(
                builder: (_) =>
                    EditStudentScreen(settings.arguments as Student),
              );
            case '/':
            default:
              return MaterialPageRoute(
                builder: (_) => BaseScreen(),
              );
          }
        },
      ),
    );
  }
}
