import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexor/nexor.dart';

abstract base class BaseCubit<T> extends Cubit<T> {
  BaseCubit(super.initialState);

  void safeEmit(T state) {
    if (isClosed) return;
    emit(state);
  }

  FV init();
}
