import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_event.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DialogBloc extends Bloc<DialogEvent, DialogState> {
  DialogBloc() : super(const DialogClosed()) {
    on<OpenDialog>(_openDialog);
    on<CloseDialog>(_closeDialog);
  }

  void _openDialog(OpenDialog event, Emitter<DialogState> emit) {
    emit(
      DialogOpened(builder: event.builder),
    );
  }

  void _closeDialog(CloseDialog event, Emitter<DialogState> emit) {
    emit(
      const DialogClosed(),
    );
  }
}
