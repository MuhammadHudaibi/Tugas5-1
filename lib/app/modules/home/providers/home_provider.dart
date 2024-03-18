import 'package:get/get.dart';
import 'package:tugas5_1learningx/app/modules/home/models/home_model.dart';

class HomeProvider extends GetConnect {
  Future<HomeModel> fetchHomeData() async {
    final response = await get('https://www.themealdb.com/api/json/v1/1/categories.php');

    if (response.status.isOk) {
      return HomeModel.fromJson(response.body);
    } else {
      throw Exception('Failed to load home data: ${response.statusText}');
    }
  }
}
