import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/getit_settings.dart';

extension BuildContextExtension on BuildContext {
  void go(AppRoute route, {dynamic data}) {
    if (mounted) {
      getIt<INavigationController>().go(route.name, this, data: data);
    }
  }

  void back() {
    if (mounted) {
      getIt<INavigationController>().off(this);
    }
  }

  void goOffAll(AppRoute route, {data}) {
    if (mounted) {
      getIt<INavigationController>().goOffAll(route.name, this, data: data);
    }
  }

  X cubit<X extends StateStreamableSource<Object?>>() =>
      BlocProvider.of<X>(this);
}
