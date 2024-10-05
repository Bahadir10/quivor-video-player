import 'package:flutter/widgets.dart';
import 'package:quivor/utils/strings.dart';

final class AppText extends Text {
  AppText(Strings text, {super.style}) : super(text.value);
}
