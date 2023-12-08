import 'package:bloc_tutorial_todo/core/constants/vectors.dart';
import 'package:bloc_tutorial_todo/features/todos/presentation/pages/home_page.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/pages/weather_page.dart';
import 'package:bloc_tutorial_todo/shared/bottom_tabs/bloc/bottom_tabs_bloc.dart';
import 'package:bloc_tutorial_todo/shared/bottom_tabs/bloc/bottom_tabs_event.dart';
import 'package:bloc_tutorial_todo/shared/bottom_tabs/bloc/bottom_tabs_state.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_bloc.dart';
import 'package:bloc_tutorial_todo/shared/dialog/bloc/dialog_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomTabs extends StatelessWidget {
  const BottomTabs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DialogBloc, DialogState>(
      listener: (context, state) {
        if (state is DialogOpened) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: state.builder,
            );
          });
        }
      },
      child: Scaffold(
        body: BlocBuilder<BottomTabsBloc, BottomTabsState>(
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is TodoPageSelected) {
              return const HomePage();
            } else if (state is WeatherPageSelected) {
              return const WeatherPage();
            } else {
              return const Center(
                child: Text('Something went wrong'),
              );
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: context.read<BottomTabsBloc>().state.selectedIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (index) {
            context.read<BottomTabsBloc>().add(
                  SwitchTab(selectedIndex: index),
                );
          },
          items: [
            BottomNavigationBarItem(
              label: '',
              icon: BlocBuilder<BottomTabsBloc, BottomTabsState>(
                builder: (_, state) {
                  if (state is TodoPageSelected) {
                    return SvgPicture.asset(homeBoldVector);
                  } else {
                    return SvgPicture.asset(homeOutlineVector);
                  }
                },
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: BlocBuilder<BottomTabsBloc, BottomTabsState>(
                builder: (_, state) {
                  if (state is WeatherPageSelected) {
                    return SvgPicture.asset(searchBoldVector);
                  } else {
                    return SvgPicture.asset(searchOutlineVector);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
