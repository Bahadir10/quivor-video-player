import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quivor/core/bloc/base_cubit.dart';

class CustomBlocProvider<X extends BaseCubit> extends BlocProvider<X> {
  CustomBlocProvider(
      {super.key,
      required X Function(BuildContext context) create,
      super.child})
      : super(
          create: (context) => create(context)..init(),
        );
}
