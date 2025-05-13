import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/database/db.dart';
import 'package:project/src/authentication/signin/signinpage.dart';
import 'package:project/src/states/sharedpreferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:project/src/authentication/login/loginpage.dart';
import 'package:project/src/main/app/screens/apppage.dart';
import 'package:project/src/states/login.dart';
//import 'package:project/src/rust/api/simple.dart';
import 'package:project/src/rust/frb_generated.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  await RustLib.init();
  runApp(ProviderScope(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(sharedPreferences),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    if (kIsWeb) {
    } else {
      initDb();
      print("Database initiated");
    }

    super.initState();
  }

  void initDb() async {
    await ChatDatabase.instance.database;
  }

  Widget build(BuildContext context) {
    final state = ref.watch(loginProvider);
    Widget initialScreen = Loginpage();
    if (state) {
      initialScreen = const AppPage();
    }
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          home: initialScreen,
          routes: {
            'App': (BuildContext context) => const AppPage(),
            '/Login': (BuildContext context) => Loginpage(),
            '/Signin': (BuildContext context) => const SigninPage(),
          },
          title: 'Flutter Demo',
          theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.black,
            useMaterial3: true,
          ),
        );
      },
    );
  }
}
