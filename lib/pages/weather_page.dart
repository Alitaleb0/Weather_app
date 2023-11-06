import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:Weather_app/services/weather_service.dart';
import '../models/weather_model.dart';

// /////////////////////////////////////////
/*import '../models/weather_model_2.dart';*/

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();

}

class _WeatherPageState extends State<WeatherPage> {

    /*متغير private*/    /*دالة من class اخر تأخذ قيمة api */
  final _weatherService = WeatherService('a01eb793fb10d56aa546101014865af5');

  //late List<Weather_2> forecasts;// 2

  Weather? _weather; //متغير يحمل قيمة _weather ويمكن ان يكون فارقا

// fetch weather
  _fetchWeather() async{
    // get the current city // ووضعف في متغير class جلب اسم المدينة من
    String cityName = await _weatherService.getCurrentCity();
    // get weather for city
    try{ // معرفة حالة الطقس بستخدام اسم المدينة
      final weather = await _weatherService.getWeather(cityName);
      setState(()  {
        _weather = weather;
      });
    }
    catch(e){
      print(e);
    }

  }


// weather animations
  String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null) return 'assets/sunny.json'; // defult to sunny
    switch(mainCondition.toLowerCase()){
      case 'cloud':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/sunny.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:
        return 'assets/sunny.json';

    }
  }

  //init state
  @override
  void initState() {
    super.initState();

    //fetch weather on startup
    _fetchWeather();
  }

// دالة تُرجع لون الخلفية بناءً على الوقت من اليوم
  String getBackgroundColor(String? col) {
    // الحصول على وقت الجهاز الحالي
    DateTime now = DateTime.now();

    // تحديد لون الخلفية بناءً على الوقت من اليوم
    if (now.hour >= 18 || now.hour <= 6) {
      // الليل
      return col = "Night";
    } else {
      // النهار
      return col = "White";
    }
  }
  /////////////////////////////////////////////////////////////////////////////////////////////////////



  ///////////////////////////////////////////////////////////////////////////////////////////////////

  @override
  Widget build(BuildContext context) {
    //if (forecasts == null) {return Center(child: CircularProgressIndicator());} //2

    ///////////////////////////////////
    return Scaffold(

      backgroundColor: (getBackgroundColor("White") == "Night") ? Colors.grey[800] : Colors.white,
      //backgroundColor: Colors.grey[800],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Container(
              height: 50.0,
              width: 50.0,
              alignment: Alignment(0.0, -0.5), // القيمة الأولى تمثل محاذاة الأفقية والثانية تمثل محاذاة الرأسية
              child: Icon(Icons.location_on_rounded, ),
            ),



            // city name
            Text(_weather?.cityName ?? "loading city..."),

            // animation
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),

            // temperatur
            Text('${_weather?.temperature.round()} ℃'),

            // weather condition
            Text(_weather?.mainCondition ?? ""),

/*
            Row(children: [
              /////////////////////////////////////////////////////////////////////////////////
                ListView.builder( /* */
                    itemCount: forecasts.length,
                        itemBuilder: (context, index) { return Card(child: ListTile(
                              title: Text(forecasts[index].dailycity),
                              subtitle: Text(forecasts[index].dailydescription),
                              trailing: Text('${forecasts[index].dailytemp}°C'), ),
                        ); } ),
              /////////////////////////////////////////////////////////////////////////////////
            ],),
*/

          ],
        ),
      ),
    );
  }
}
