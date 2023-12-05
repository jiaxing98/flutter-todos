import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class DialogState extends Equatable {
  const DialogState();

  @override
  List<Object> get props => [];
}

class DialogOpened extends DialogState {
  final Widget Function(BuildContext context) builder;

  const DialogOpened({required this.builder});

  @override
  List<Object> get props => [builder];
}

class DialogClosed extends DialogState {
  const DialogClosed();
}
