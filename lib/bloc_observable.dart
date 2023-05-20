import 'dart:developer';
import 'dart:html';

import 'package:flutter_bloc/flutter_bloc.dart';

class CharacterBlocObservable extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('on Event log: ${bloc.runtimeType} -- Event: $event');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    // TODO: implement onError
    super.onError(bloc, error, stackTrace);
    log('on Error log: ${bloc.runtimeType} -- Error: $error');
  }
}
