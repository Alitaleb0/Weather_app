import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import '../models/weather_model.dart';
import 'package:http/http.dart' as http;
///////////////////////////////////////////


class WeatherService{

  // متغير لا يمكن تغيير قيمته
  static const BASE_URL = 'http://api.openweathermap.org/data/2.5/weather'; // الموقع الذي سيجلب منه بيانات الطقس
  //static const BASE_URL_2 = 'http://api.openweathermap.org/data/2.5/forecast'; // /////// 2
  //متغير لا يمكن تغيير قيمته بعد تعيينها
  final String apiKey;

  WeatherService(this.apiKey);

  // دالة تستخدم معامل من نوع String لتحديد اسم المدينة
  Future<Weather> getWeather(String cityName) async {/*متغير لأسم المدينة*/ /*لغة العرض*/
  final response = await http.get(Uri.parse('$BASE_URL?q=$cityName&lang=ar&appid=$apiKey&units=metric'));

      if(response.statusCode == 200){
        return Weather.fromJson(jsonDecode(response.body));
      }else{
        throw Exception('Failed to load weather date');
      }
  }
  // للحصول على المدينة + التحقق من الأذن
  Future<String> getCurrentCity() async{
    // الحصول على اذن من المستخدم
    LocationPermission permission = await Geolocator.checkPermission();
    if(permission == LocationPermission.denied){ /* اذا تم الرفض */
      permission = await Geolocator.requestPermission(); // طلب الإذن من المستخدم مرة أخرى
      }
    // جلب الموقع الحالي من المستخدم ثم تخزن في position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.low // مستوى الدقة الطلوب لجلب الموقع
    );
    // تحويل الموقع الى قائمة
    List<Placemark> placemarks =
    await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name from the first placemark - استخراج اسم المدينة من العلامة الموضعية الأولى
    String? city = placemarks[0].locality;

    return city ?? ""; // لتجنب القيم null أو undefined
    }
//////////////////////////////////////////////////////////////////////////////////////////////////////
/*
  // دالة تستخدم معامل من نوع String لتحديد اسم المدينة
  Future<List<Weather_2>> getWeather_2(String cityName) async {
    final response_2 = await http.get(Uri.parse('$BASE_URL_2?q=$cityName&lang=ar&appid=$apiKey&units=metric'));//2

    // معالجة الاستجابة
    if (response_2.statusCode == 200) {
      // استرداد البيانات من الاستجابة
      Map<String, dynamic> data = json.decode(response_2.body);
      // إنشاء قائمة من توقعات الطقس
      List<Weather_2> forecasts = [];
      for (var item in data['list']) {
        forecasts.add(Weather_2(// api الأسماء الموجودة في رابط
          dailycity: item['city']['name'],
          dailydescription : item['weather'][0]['description'],
          dailytemp : item['main']['temp'],
        ));
      }

      return forecasts;
    } else {
      throw Exception('Failed to get forecast');
    }
  }
 */
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////

}
