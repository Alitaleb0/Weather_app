class Weather { /* متغيرات ثابتت القيم */
  final String cityName;
  final double temperature;
  final String mainCondition;

  // دالة
  Weather({/* يجب تمرير قيمة لكل من المتغيرات عند استدعاء الدالة*/
    required this.cityName,
    required this.temperature,
    required this.mainCondition,
  });

  //يتم اعطاء قيم للمتغيرات من  بيانات JSON
  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
        cityName: json['name'],
        temperature: json['main']['temp'].toDouble(),
        mainCondition: json['weather'][0]['main']);
  }
}
/*
class Weather_2 {
  final String dailycity;
  final String dailydescription;
  final double dailytemp;

  Weather_2({
    required this.dailycity,
    required this.dailydescription,
    required this.dailytemp,
  });

  factory Weather_2.fromJson(Map<String, dynamic> json) {
    return Weather_2(
      dailycity: json['name'],
      dailydescription: json['main']['temp'].toDouble(),
      dailytemp: json['weather'][0]['main']);
  }
 */