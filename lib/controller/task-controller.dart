import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class TaskController extends GetxController{
  final isLoading=true.obs;
  final isLiked=false.obs;
  final isVisible=true.obs;

  var postList=[].obs ;

  @override
  void onInit() {
    super.onInit();

  }

  void passVisible(){
    isVisible.value=!isVisible.value;

  }
  void toggleLike(){
    isLiked.value=!isLiked.value;
  }



}