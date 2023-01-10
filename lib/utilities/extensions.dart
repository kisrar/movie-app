import 'package:flutter/material.dart';

extension PaddingExtension on Widget {
  Padding addPadding(double value){
    return Padding(padding: EdgeInsets.all(value),child: this);
  }
}