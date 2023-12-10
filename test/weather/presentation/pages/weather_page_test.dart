import 'package:bloc_test/bloc_test.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_bloc.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_event.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_state.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/pages/weather_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockWeatherBloc extends MockBloc<WeatherEvent, WeatherState>
    implements WeatherBloc {}

void main() {
  late MockWeatherBloc mockWeatherBloc;

  setUp(() {
    mockWeatherBloc = MockWeatherBloc();
  });

  tearDown(() {
    mockWeatherBloc.close();
  });

  Widget _makeTestableWidget(Widget body) => BlocProvider<WeatherBloc>(
        create: (context) => mockWeatherBloc,
        child: MaterialApp(
          home: body,
        ),
      );

  group('test weather page', () {
    testWidgets(
        'text field should trigger state to change from empty to loading',
        (widgetTester) async {
      // arrange
      whenListen(
        mockWeatherBloc,
        Stream.fromIterable([WeatherEmpty(), WeatherLoading()]),
        initialState: WeatherEmpty(),
      );

      // act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
      var textField = find.byType(TextField);

      // assert
      expect(textField, findsOneWidget);
      await widgetTester.enterText(textField, 'New York');
      await widgetTester.pump();
      expect(find.text('New York'), findsOneWidget);
    });

    testWidgets('should show progress indicator when state is loading',
        (widgetTester) async {
      // arrange
      whenListen(
        mockWeatherBloc,
        Stream.fromIterable([WeatherEmpty(), WeatherLoading()]),
        initialState: WeatherLoading(),
      );

      // act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));

      // assert
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show Text when state is error', (widgetTester) async {
      // arrange
      whenListen(
        mockWeatherBloc,
        Stream.fromIterable([
          WeatherEmpty(),
          WeatherLoading(),
          const WeatherError('Something went wrong.'),
        ]),
        initialState: WeatherEmpty(),
      );

      // act
      await widgetTester.pumpWidget(_makeTestableWidget(const WeatherPage()));
      await widgetTester
          .pumpAndSettle(); // wait for async operations to complete.

      // assert
      expect(find.text('Something went wrong.'), findsOneWidget);
    });
  });
}
