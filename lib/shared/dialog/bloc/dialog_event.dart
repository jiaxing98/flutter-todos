import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class DialogEvent extends Equatable {
  const DialogEvent();

  @override
  List<Object> get props => [];
}

class OpenDialog extends DialogEvent {
  final Widget Function(BuildContext context) builder;

  const OpenDialog({required this.builder});

  @override
  List<Object> get props => [builder];
}

class CloseDialog extends DialogEvent {
  const CloseDialog();
}
