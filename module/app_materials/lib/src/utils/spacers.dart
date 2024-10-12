import 'package:flutter/material.dart';

enum Spacers {
  low(4),
  small(8),
  medium(16),
  high(32);

  final double value;

  const Spacers(this.value);

  String call() => name;

  SizedBox get all => SizedBox(
        height: value,
        width: value,
      );

  SizedBox get horizontal => SizedBox(
        width: value,
      );
  SizedBox get vertical => SizedBox(
        height: value,
      );
}

enum Paddings {
  low(4),
  small(8),
  medium(16),
  high(32);

  final double value;

  const Paddings(this.value);
  EdgeInsets get zero => EdgeInsets.zero;
  EdgeInsets get all => EdgeInsets.all(value);
  EdgeInsets get horizontal => EdgeInsets.only(left: value, right: value);
  EdgeInsets get vertical => EdgeInsets.only(top: value, bottom: value);
  EdgeInsets get top => EdgeInsets.only(top: value);
  EdgeInsets get bottom => EdgeInsets.only(bottom: value);
  EdgeInsets get left => EdgeInsets.only(left: value);
  EdgeInsets get right => EdgeInsets.only(right: value);
  EdgeInsets get topLeft => EdgeInsets.only(top: value, left: value);
  EdgeInsets get topRight => EdgeInsets.only(top: value, right: value);
  EdgeInsets get bottomLeft => EdgeInsets.only(bottom: value, left: value);
  EdgeInsets get bottomRight => EdgeInsets.only(bottom: value, right: value);
}

enum Cutter {
  low(4),
  small(8),
  medium(16),
  high(32);

  final double value;

  const Cutter(this.value);

  BorderRadius get zero => BorderRadius.zero;
  BorderRadius get all => BorderRadius.all(value.circularRadius);
  BorderRadius get horizontalLeft =>
      BorderRadius.horizontal(left: value.circularRadius);
  BorderRadius get horizontalRight =>
      BorderRadius.horizontal(right: value.circularRadius);
  BorderRadius get verticalTop =>
      BorderRadius.vertical(top: value.circularRadius);
  BorderRadius get verticalBottom =>
      BorderRadius.vertical(bottom: value.circularRadius);
  BorderRadius get topLeft => BorderRadius.only(topLeft: value.circularRadius);
  BorderRadius get topRight =>
      BorderRadius.only(topRight: value.circularRadius);
  BorderRadius get bottomLeft =>
      BorderRadius.only(bottomLeft: value.circularRadius);
  BorderRadius get bottomRight =>
      BorderRadius.only(bottomRight: value.circularRadius);
}

extension on double {
  Radius get circularRadius => Radius.circular(this);
}
