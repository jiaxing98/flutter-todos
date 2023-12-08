import 'package:equatable/equatable.dart';

abstract class BottomTabsState extends Equatable {
  final int selectedIndex;

  const BottomTabsState({required this.selectedIndex});

  @override
  List<Object?> get props => [];
}

class TodoPageSelected extends BottomTabsState {
  const TodoPageSelected() : super(selectedIndex: 0);
}

class WeatherPageSelected extends BottomTabsState {
  const WeatherPageSelected() : super(selectedIndex: 1);
}
