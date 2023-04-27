import 'dart:typed_data' show Uint8List;

import 'package:flutter/foundation.dart' show immutable;

@immutable
class AppState {
  final bool isLoading;
  final Uint8List? data;
  final Object? error;

  const AppState({
    required this.isLoading,
    required this.data,
    this.error,
  });

  const AppState.empty()
      : data = null,
        error = null,
        isLoading = false;

  @override
  String toString() {
    return {
      "isLoading": isLoading,
      "hasData": data != null,
      "error": error,
    }.toString();
  }
}
