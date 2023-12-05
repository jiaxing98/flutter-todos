import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_bloc.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String positiveLabel;
  final String negativeLabel;
  final Function? onPositive;
  final Function? onNegative;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    required this.positiveLabel,
    required this.negativeLabel,
    this.onPositive,
    this.onNegative,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(positiveLabel),
          onPressed: () {
            onPositive?.call();
            Navigator.of(context).pop();
            context.read<DialogBloc>().add(const CloseDialog());
          },
        ),
        TextButton(
          style: TextButton.styleFrom(
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: Text(negativeLabel),
          onPressed: () {
            onNegative?.call();
            Navigator.of(context).pop();
            context.read<DialogBloc>().add(const CloseDialog());
          },
        ),
      ],
    );
  }
}
