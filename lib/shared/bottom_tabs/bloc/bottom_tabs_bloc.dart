import 'package:bloc_tutorial_todo/shared/bottom_tabs/bloc/bottom_tabs_event.dart';
import 'package:bloc_tutorial_todo/shared/bottom_tabs/bloc/bottom_tabs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomTabsBloc extends Bloc<BottomTabsEvent, BottomTabsState> {
  BottomTabsBloc() : super(const TodoPageSelected()) {
    on<SwitchTab>(_switchTab);
  }

  void _switchTab(SwitchTab event, Emitter<BottomTabsState> emit) {
    switch (event.selectedIndex) {
      case 0:
        emit(
          const TodoPageSelected(),
        );
      case 1:
        emit(
          const WeatherPageSelected(),
        );
      default:
        emit(
          const TodoPageSelected(),
        );
    }
  }
}
