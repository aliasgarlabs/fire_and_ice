import 'package:fire_and_ice/FireOrIceModel.dart';
import 'package:fire_and_ice/FireOrIceRepository.dart';
import 'package:get/get.dart';

class FireOrIceController extends GetxController {
  FireOrIceRepository fireOrIceRepository = FireOrIceRepository();

  FireOrIceModel fireOrIceModel =
      FireOrIceModel(emoji: '', date: DateTime.now().toString());

  Future<FireOrIceModel> getFireOrIce() async {
    if (fireOrIceModel.emoji.isEmpty) {
      fireOrIceModel = await fireOrIceRepository.getLatestFireOrIce();
    }

    update();

    return fireOrIceModel;
  }

  Future<void> updateFireOrIce() async {
    fireOrIceRepository.updateFireOrIce(fireOrIceModel);
  }
}
