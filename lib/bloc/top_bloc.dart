import 'package:bloc_multiprovider_example/bloc/app_bloc.dart';

class TopBloc extends AppBloc {
  TopBloc({
    Duration? waitingBeforeLoading,
    required Iterable<String> urls,
  }) : super(
          urls: urls,
          waitBeforeLoading: waitingBeforeLoading,
        );
}
