import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project/src/main/app/screens/apppage.dart';
import 'package:project/src/authentication/login/loginpage.dart';
import 'package:project/src/states/login.dart';
import 'package:project/src/database/db.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class MainPage extends ConsumerStatefulWidget {
  const MainPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MainPageState();
}

class _MainPageState extends ConsumerState<MainPage> {
  @override
  void initState() {
    // TODO: implement initState
    if (kIsWeb) {
    } else {
      initDb();
    }

    super.initState();
  }

  void initDb() async {
    await ChatDatabase.instance.database;
  }

  @override
  Widget build(BuildContext context) {
    final logstate = ref.watch(loginProvider);
    print("from homepage ${logstate}");
    if (logstate == false) {
      return (Loginpage());
      //Navigator.pushNamedAndRemoveUntil(context, '/Login', (route) => false);
    } else {
      return (const AppPage());
    }
  }
}
/*
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final logstate = ref.watch(loginProvider);
    return logstate ? const HomePage1() : const LoginPage();
    /*if (logstate < 5) {
      return (HomePage1());
    } else {
      return (LoginPage());
    }*/
  }
}*/
