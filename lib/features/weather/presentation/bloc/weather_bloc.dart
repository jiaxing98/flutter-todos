import 'package:bloc_tutorial_todo/features/weather/domain/usecases/get_current_weather.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_event.dart';
import 'package:bloc_tutorial_todo/features/weather/presentation/bloc/weather_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeatherUseCase _getCurrentWeatherUseCase;
  WeatherBloc(this._getCurrentWeatherUseCase) : super(WeatherEmpty()) {
    on<OnCityChanged>(
      _onLoadWeather,
      transformer: debounce(const Duration(milliseconds: 500)),
    );
  }

  EventTransformer<T> debounce<T>(Duration duration) {
    return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
  }

  void _onLoadWeather(OnCityChanged event, Emitter<WeatherState> emit) async {
    if (event.cityName == '') {
      emit(WeatherEmpty());
      return;
    }

    emit(WeatherLoading());

    final result = await _getCurrentWeatherUseCase(event.cityName);
    result.fold(
      (ex) => emit(WeatherError(ex.message)),
      (data) => emit(WeatherLoaded(data)),
    );
  }
}
