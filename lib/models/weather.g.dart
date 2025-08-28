// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      timezone: json['timezone'] as String,
      current: Current.fromJson(json['current'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lon': instance.lon,
      'timezone': instance.timezone,
      'current': instance.current,
    };

Current _$CurrentFromJson(Map<String, dynamic> json) => Current(
      dt: (json['dt'] as num).toInt(),
      temp: (json['temp'] as num).toDouble(),
      humidity: (json['humidity'] as num).toInt(),
      wind_speed: (json['wind_speed'] as num).toDouble(),
      weather: (json['weather'] as List<dynamic>)
          .map((e) => WeatherInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CurrentToJson(Current instance) => <String, dynamic>{
      'dt': instance.dt,
      'temp': instance.temp,
      'humidity': instance.humidity,
      'wind_speed': instance.wind_speed,
      'weather': instance.weather,
    };

WeatherInfo _$WeatherInfoFromJson(Map<String, dynamic> json) => WeatherInfo(
      id: (json['id'] as num).toInt(),
      main: json['main'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
    );

Map<String, dynamic> _$WeatherInfoToJson(WeatherInfo instance) =>
    <String, dynamic>{
      'id': instance.id,
      'main': instance.main,
      'description': instance.description,
      'icon': instance.icon,
    };
