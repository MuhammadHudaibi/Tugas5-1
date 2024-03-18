import 'package:get/get.dart';
import 'package:tugas5_1learningx/app/modules/home/models/home_model.dart';
import 'package:tugas5_1learningx/app/modules/home/providers/home_provider.dart';

class HomeController extends GetxController {
  final HomeProvider _homeProvider = HomeProvider();
  var homeData = HomeModel(categories: []).obs; 
  var isLoading = true.obs;
  var filteredCategories = <Category>[].obs; 

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    try {
      isLoading(true); // Set isLoading menjadi true saat sedang mengambil data
      var data = await _homeProvider.fetchHomeData();
      homeData(data); // Set data yang diambil dari API ke homeData
    } catch (error) {
      // Handle error, for example:
      print('Error fetching home data: $error');
    } finally {
      isLoading(false); // Set isLoading menjadi false setelah selesai mengambil data
    }
  }
}
