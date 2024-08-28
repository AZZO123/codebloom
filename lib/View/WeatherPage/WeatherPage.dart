// ignore_for_file: library_private_types_in_public_api

import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:palnt_app/Model/Weathe.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

Future<List<Weather>> fetchWeather() async {
  final response = await http.get(Uri.parse(
      'https://api.openweathermap.org/data/2.5/forecast?q=Damascus,SY&units=metric&lang=ar&appid=9d38eef927e7db4eb55df96a6633255d'));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    log(data.toString());
    final List<dynamic> weatherList = data['list'];

    List<Weather> dailyWeather = [];
    String lastDate = '';

    for (var item in weatherList) {
      String dateTime = item['dt_txt'];
      String date = dateTime.split(' ')[0];
      String time = dateTime.split(' ')[1];

      if (date != lastDate && time.startsWith('12:00')) {
        dailyWeather.add(Weather.fromJson(item));
        lastDate = date;
      }
    }

    return dailyWeather;
  } else {
    throw Exception('Failed to load weather data');
  }
}

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<List<Weather>> futureWeather;

  @override
  void initState() {
    super.initState();
    futureWeather = fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Weather>>(
        future: futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('خطأ: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('لا توجد بيانات متاحة'));
          }

          final weatherList = snapshot.data!;

          return ListView.builder(
            itemCount: weatherList.length,
            itemBuilder: (context, index) {
              final weather = weatherList[index];
              return Card(
                child: ListTile(
                  leading: Image.network(
                      'https://openweathermap.org/img/wn/${weather.icon}@2x.png'),
                  title: Text(
                    '${intl.DateFormat('yyyy-MM-dd').format(DateTime.parse(weather.date))}',
                    textDirection: TextDirection.rtl,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'الوصف: ${weather.description}',
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        'درجة الحرارة: ${weather.temperature}°C',
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        'الرطوبة: ${weather.humidity}%',
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        'سرعة الرياح: ${weather.windSpeed} م/ث',
                        textDirection: TextDirection.rtl,
                      ),
                      Text(
                        'الضغط الجوي: ${weather.pressure} hPa',
                        textDirection: TextDirection.rtl,
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
