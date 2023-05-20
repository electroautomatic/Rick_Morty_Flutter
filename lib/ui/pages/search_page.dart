import 'dart:async';

import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rick_morty/bloc/character_bloc.dart';
import 'package:flutter_rick_morty/data/models/chracter.dart';
import 'package:flutter_rick_morty/ui/wigets/custom_list_tile.dart';
import 'package:freeze/freeze.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late Character _carrentCaracter;
  List<Results> _currentresults = [];
  int _currentPage = 1;
  String _currentSearchStr = '';

  final RefreshController refreshController = RefreshController();
  bool _isPagination = false;

  Timer? searchBebounce;

  @override
  void initState() {
    if (_currentresults.isEmpty) {
      context
          .read<CharacterBloc>()
          .add(const CharacterEvent.fetch(name: '', page: 1));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.watch<CharacterBloc>().state;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: TextField(
            style: const TextStyle(color: Colors.white),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(86, 86, 86, 0.8),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              prefixIcon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              hintText: 'Search:',
              hintStyle: const TextStyle(color: Colors.white),
            ),
            onChanged: (value) {
              _currentPage = 1;
              _currentresults = [];
              _currentSearchStr = value;

              searchBebounce?.cancel();
              searchBebounce = Timer(const Duration(milliseconds: 500), () {
                context
                    .read<CharacterBloc>()
                    .add(CharacterEvent.fetch(name: value, page: _currentPage));
              });
            },
          ),
        ),
        Expanded(
          child: state.when(
            loading: () {
              if (!_isPagination) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text('loading.....'),
                    ],
                  ),
                );
              } else {
                return _customListView(_currentresults);
              }
            },
            loaded: (characterLoaded) {
              _carrentCaracter = characterLoaded;
              if (_isPagination) {
                _currentresults.addAll(_carrentCaracter.results);
                refreshController.loadComplete();
                _isPagination = false;
              } else {
                _currentresults.addAll(_carrentCaracter.results);
                // _currentresults = _carrentCaracter.results;
              }
              return _currentresults.isNotEmpty
                  // ?
                  ? _customListView(_currentresults)
                  : const SizedBox();
            },
            error: () => const Text('Nothing found...!!!'),
          ),
        ),
      ],
    );
  }

  Widget _customListView(List<Results> curentResults) {
    return SmartRefresher(
      controller: refreshController,
      enablePullUp: true,
      enablePullDown: false,
      onLoading: () {
        _isPagination = true;
        _currentPage++;
        if (_currentPage <= _carrentCaracter.info.pages) {
          context.read<CharacterBloc>().add(CharacterEvent.fetch(
              name: _currentSearchStr, page: _currentPage));
        } else {
          refreshController.loadNoData();
        }
      },
      child: ListView.separated(
        itemCount: curentResults.length,
        separatorBuilder: (_, index) => const SizedBox(
          height: 5,
        ),
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final result = curentResults[index];
          return Padding(
            padding:
                const EdgeInsets.only(right: 16, left: 16, top: 3, bottom: 3),
            child: CustomListTile(result: result),
          );
        },
      ),
    );
  }
}
