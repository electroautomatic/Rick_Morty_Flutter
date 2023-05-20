import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_morty/bloc_observable.dart';
import 'package:flutter_rick_morty/ui/pages/home_page.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );
  // runApp(const MyApp());
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
    blocObserver: CharacterBlocObservable(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rick & Morty',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.black,
        fontFamily: 'Georgia',
        textTheme: const TextTheme(
          headline1: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, color: Colors.white),
          headline2: TextStyle(
              fontSize: 30, fontWeight: FontWeight.w100, color: Colors.white),
          headline3: TextStyle(fontSize: 24, color: Colors.white),
          bodyText1: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w200, color: Colors.white),
          bodyText2: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w500, color: Colors.white),
          caption: TextStyle(
              fontSize: 11, fontWeight: FontWeight.w100, color: Colors.grey),
        ),
      ),
      home: HomePage(title: 'Rick & Morty'),
    );
  }
}
