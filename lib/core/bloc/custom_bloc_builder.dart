import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quivor/core/bloc/base_state.dart';

Widget _builder<S extends BaseState>(BuildContext context, S state) {
  if (state.isLoading) {
    return const Center(child: CircularProgressIndicator());
  }
  return _builder(context, state);
}

class CustomCubitBuilder<B extends StateStreamable<S>, S extends BaseState>
    extends BlocBuilder<B, S> {
  CustomCubitBuilder({required Widget Function(BuildContext, S) builder})
      : super(
          builder: (context, state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }
            return builder(context, state);
          },
        );
}
