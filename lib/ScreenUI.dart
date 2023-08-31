import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ideausher/controller.dart';
import 'package:ideausher/healthCard.dart';

class HealthDataScreenUI extends StatelessWidget {
  final HealthDataScreen controller = Get.put(HealthDataScreen());
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  Future<void> _refreshData() async {
    await controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          key: _refreshIndicatorKey,
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "HI!",
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'Nunito-VariableFont_wght',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2, // Number of health cards
                  itemBuilder: (context, index) {
                    return GetBuilder<HealthDataScreen>(
                      init: HealthDataScreen(),
                      builder: (controller) {
                        if (index == 0) {
                          return healthCard(
                            title: "Steps: ",
                            image: "assets/ion_footsteps-sharp.png",
                            data: controller.steps.value,
                            currentSteps: controller.healthData.length,
                            maxSteps: 100,
                            color: const Color(0xFF2086fd),
                          );
                        } else {
                          double energyValue =
                              double.tryParse(controller.activeEnergy.value) ??
                                  0.0;
                          String energyText = energyValue > 0.0
                              ? "${(energyValue / 1000).toStringAsFixed(2)}"
                              : "";

                          return healthCard(
                            title: "Calories Burned",
                            image: "assets/kcal 1.png",
                            data: energyText,
                            color: const Color(0xFFf77e7e),
                          );
                        }
                      },
                    );
                  },
                ),
                TextButton(
                    onPressed: _refreshData,
                    child: Text(
                      'refresh',
                      style: TextStyle(color: Colors.black),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
