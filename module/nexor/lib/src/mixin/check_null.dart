import 'package:nexor/nexor.dart';

mixin CheckNullsMixin on Object {
  List<Object?> get nullCheckProps;

  bool get checkNulls => nullCheckProps.every((x) => x.isNotNull);

}
