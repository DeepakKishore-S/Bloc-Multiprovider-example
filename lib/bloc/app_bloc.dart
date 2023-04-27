import 'package:bloc_multiprovider_example/bloc/app_state.dart';
import 'package:bloc_multiprovider_example/bloc/bloc_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef AppBlocRandomUrlPicker = String Function(Iterable<String>);

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc(
    AppBlocRandomUrlPicker? urlPicker
  ) : super(const AppState.empty());
}
