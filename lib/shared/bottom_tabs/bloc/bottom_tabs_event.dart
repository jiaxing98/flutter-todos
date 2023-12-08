import 'package:equatable/equatable.dart';

abstract class BottomTabsEvent extends Equatable {
  const BottomTabsEvent();

  @override
  List<Object?> get props => [];
}

class SwitchTab extends BottomTabsEvent {
  final int selectedIndex;

  const SwitchTab({required this.selectedIndex});

  @override
  List<Object?> get props => [selectedIndex];
}
