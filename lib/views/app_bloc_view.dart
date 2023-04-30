import 'package:bloc_multiprovider_example/bloc/app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_multiprovider_example/bloc/app_bloc.dart';
import 'package:bloc_multiprovider_example/bloc/bloc_events.dart';
import 'package:bloc_multiprovider_example/extension/stream/start_with.dart';
import 'package:flutter/material.dart';

class AppBlocView<T extends AppBloc> extends StatelessWidget {
  const AppBlocView({super.key});

  void startUpdateingBloc(BuildContext context) {
    Stream.periodic(
      const Duration(seconds: 10),
      (computationCount) => const LoadNextUrlEvent(),
    ).startWith(const LoadNextUrlEvent()).forEach((event) {
      context.read<T>().add(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    startUpdateingBloc(context);
    return Expanded(
      child: BlocBuilder<T, AppState>(
        builder: (context, state) {
          if (state.error != null) {
            return const Text("Something went wrong, try again later");
          } else if (state.data != null) {
            return Image.memory(
              state.data!,
              fit: BoxFit.fitHeight,
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
