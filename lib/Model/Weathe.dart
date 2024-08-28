class Weather {
  final String date;
  final double temperature;
  final String description;
  final String icon;
  final int humidity;
  final double windSpeed;
  final int pressure;

  Weather({
    required this.date,
    required this.temperature,
    required this.description,
    required this.icon,
    required this.humidity,
    required this.windSpeed,
    required this.pressure,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      date: json['dt_txt'],
      temperature: json['main']['temp'].toDouble(),
      description: json['weather'][0]['description'],
      icon: json['weather'][0]['icon'],
      humidity: json['main']['humidity'], // الحصول على الرطوبة
      windSpeed: json['wind']['speed'].toDouble(), // الحصول على سرعة الرياح
      pressure: json['main']['pressure'], // الحصول على الضغط الجوي
    );
  }
}
