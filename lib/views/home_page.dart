import 'package:bloc_multiprovider_example/bloc/bottom_bloc.dart';
import 'package:bloc_multiprovider_example/bloc/top_bloc.dart';
import 'package:bloc_multiprovider_example/views/app_bloc_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/constants.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: MultiBlocProvider(
          providers: [
            BlocProvider<TopBloc>(
              create: (_) => TopBloc(
                urls: images,
                waitingBeforeLoading: const Duration(seconds: 3),
              ),
            ),
            BlocProvider<BottomBloc>(
              create: (_) => BottomBloc(
                urls: images,
                waitingBeforeLoading: const Duration(seconds: 3),
              ),
            ),
          ],
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: const[
              AppBlocView<TopBloc>(),
              AppBlocView<BottomBloc>(),
            ],
          ),
        ),
      ),
    );
  }
}
