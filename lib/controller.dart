import 'package:get/get.dart';
import 'package:health/health.dart';

class HealthDataScreen extends GetxController {
  var steps = "".obs;
  var activeEnergy = "".obs;

  var healthData = <HealthDataPoint>[].obs;

  final HealthFactory health = HealthFactory();

  @override
  void onInit() {
    super.onInit();
    update();
    fetchData();
  }

  Future<void> fetchData() async {
    print("steps $steps");

    final types = [
      HealthDataType.STEPS,
      HealthDataType.ACTIVE_ENERGY_BURNED,
    ];

    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(days: 1));

    final requested = await health.requestAuthorization(types);

    if (requested) {
      try {
        healthData.value =
            await health.getHealthDataFromTypes(yesterday, now, types);

        if (healthData.isNotEmpty) {
          for (HealthDataPoint h in healthData) {
            if (h.type == HealthDataType.STEPS) {
              print("h ${h.type}");
              print("hv ${h.value}");
              steps.value = "${h.value}";
            } else if (h.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
              print("ene ${h.type}");
              print("ene bur ${h.value}");
              activeEnergy.value = "${h.value}";
            }
          }
        }
      } catch (error) {
        print("Exception in getHealthDataFromTypes: $error");
      }

      healthData.value = HealthFactory.removeDuplicates(healthData);
      update();
    } else {
      print("Authorization not granted");
    }
  }
}
