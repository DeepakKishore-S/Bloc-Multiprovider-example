import 'dart:typed_data';

import 'package:bloc_multiprovider_example/bloc/app_bloc.dart';
import 'package:bloc_multiprovider_example/bloc/app_state.dart';
import 'package:bloc_multiprovider_example/bloc/bloc_events.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';

extension ToList on String {
  Uint8List toUni8List() => Uint8List.fromList(codeUnits);
}

final text1Data = "Foo".toUni8List();
final text2Data = "Boo".toUni8List();

enum Error { dummy }

void main() {
  blocTest<AppBloc, AppState>(
    'Initial state test in app bloc',
    build: () => AppBloc(urls: []),
    verify: (appState) => expect(
      appState.state,
      const AppState.empty(),
    ),
  );

  blocTest<AppBloc, AppState>('Test the bloc with valid data',
      build: () => AppBloc(
            urls: [],
            urlPicker: (_) => "",
            urlLoader: (url) => Future.value(text1Data),
          ),
      act: (bloc) => bloc.add(const LoadNextUrlEvent()),
      expect: () => [
            const AppState(
              isLoading: true,
              data: null,
              error: null,
            ),
            AppState(
              isLoading: false,
              data: text1Data,
              error: null,
            ),
          ]);

  blocTest<AppBloc, AppState>('Testing the try catch in app bloc by urlloader',
      build: () => AppBloc(
            urls: [],
            urlPicker: (_) => "",
            urlLoader: (url) => Future.error(Error.dummy),
          ),
      act: (bloc) => bloc.add(const LoadNextUrlEvent()),
      expect: () => [
            const AppState(
              isLoading: true,
              data: null,
              error: null,
            ),
            const AppState(
              isLoading: false,
              data: null,
              error: Error.dummy,
            ),
          ]);

  blocTest<AppBloc, AppState>('Test the bloc with multiple url data',
      build: () => AppBloc(
            urls: [],
            urlPicker: (_) => "",
            urlLoader: (url) => Future.value(text2Data),
          ),
      act: (bloc) {
        bloc.add(const LoadNextUrlEvent());
        bloc.add(const LoadNextUrlEvent());
      },
      expect: () => [
            const AppState(
              isLoading: true,
              data: null,
              error: null,
            ),
            AppState(
              isLoading: false,
              data: text2Data,
              error: null,
            ),
            const AppState(
              isLoading: true,
              data: null,
              error: null,
            ),
            AppState(
              isLoading: false,
              data: text2Data,
              error: null,
            ),
          ]);
}
