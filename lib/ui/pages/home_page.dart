import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_morty/bloc/character_bloc.dart';
import 'package:flutter_rick_morty/data/repositories/character_repo.dart';
import 'search_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key, required this.title});
  final String title;
  final characterRepo = CharacterRepo();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black54,
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline3,
        ),
      ),
      body: BlocProvider(
        create: (context) => CharacterBloc(characterRepo: characterRepo),
        child: Container(
            decoration: const BoxDecoration(
              color: Colors.black87,
            ),
            child: SearchPage()),
      ),
    );
  }
}
