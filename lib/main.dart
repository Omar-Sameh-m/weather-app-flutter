import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/get%20weather%20cubit/Get_weather_cubit.dart';
import 'package:weather_app/cubits/get%20weather%20cubit/get_weather_states.dart';
import 'package:weather_app/views/home_view.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetWeatherCubit(),
      child: Builder(
        builder: (BuildContext context) {
          return BlocBuilder<GetWeatherCubit, WeatherState>(
            builder: (context, state) {
              final primary = getThemeColor(
                BlocProvider.of<GetWeatherCubit>(
                  context,
                ).weatherModel?.weatherCondition,
              );

              return MaterialApp(
                theme: ThemeData(
                  useMaterial3: false,
                  colorScheme: ColorScheme.fromSwatch(primarySwatch: primary),
                  appBarTheme: AppBarTheme(
                    backgroundColor: primary,
                    foregroundColor: Colors.white,
                  ),
                ),
                debugShowCheckedModeBanner: false,
                home: HomeView(),
              );
            },
          );
        },
      ),
    );
  }
}

MaterialColor getThemeColor(String? condition) {
  final s = (condition ?? '').trim().toLowerCase();

  switch (s) {
    // Sunny / Clear
    case 'sunny':
    case 'clear':
      return Colors.orange;

    // Partly cloudy
    case 'partly cloudy':
      return Colors.amber;

    // Cloudy / Overcast
    case 'cloudy':
    case 'overcast':
      return Colors.blueGrey;

    // Mist / Fog
    case 'mist':
    case 'fog':
    case 'freezing fog':
      return Colors.grey;

    // Light drizzle / light rain / light showers
    case 'patchy light drizzle':
    case 'light drizzle':
    case 'patchy light rain':
    case 'light rain':
    case 'light rain shower':
    case 'light rain showers':
    case 'patchy light rain with thunder':
      return Colors.lightBlue;

    // Moderate / heavy rain / torrential / showers
    case 'moderate rain at times':
    case 'moderate rain':
    case 'heavy rain at times':
    case 'heavy rain':
    case 'moderate or heavy rain shower':
    case 'torrential rain shower':
    case 'moderate or heavy rain with thunder':
      return Colors.indigo;

    // Thunder-related
    case 'thundery outbreaks possible':
    case 'thunder':
    case 'patchy light snow with thunder':
    case 'moderate or heavy snow with thunder':
      return Colors.deepPurple;

    // Sleet / freezing / ice pellets
    case 'patchy sleet possible':
    case 'patchy freezing drizzle possible':
    case 'freezing drizzle':
    case 'heavy freezing drizzle':
    case 'light freezing rain':
    case 'moderate or heavy freezing rain':
    case 'light sleet':
    case 'moderate or heavy sleet':
    case 'light sleet showers':
    case 'moderate or heavy sleet showers':
    case 'ice pellets':
    case 'light showers of ice pellets':
    case 'moderate or heavy showers of ice pellets':
      return Colors.cyan;

    // Snow / blizzard / heavy snow / snow showers
    case 'patchy snow possible':
    case 'blowing snow':
    case 'blizzard':
    case 'patchy light snow':
    case 'light snow':
    case 'patchy moderate snow':
    case 'moderate snow':
    case 'patchy heavy snow':
    case 'heavy snow':
    case 'light snow showers':
    case 'moderate or heavy snow showers':
      return Colors.blue;

    // Generic patchy rain / drizzle fallback
    case 'patchy rain possible':
    case 'patchy rain':
      return Colors.lightBlue;

    // Final fallback
    default:
      return Colors.blueGrey;
  }
}
