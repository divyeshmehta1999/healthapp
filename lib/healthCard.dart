import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:linear_progress_bar/linear_progress_bar.dart';

Widget healthCard({
  String title = "",
  String data = "",
  int currentSteps = 0,
  int maxSteps = 100,
  Color color = Colors.red,
  required String image,
}) {
  Color containerColor = Get.isDarkMode ? Colors.black : Color(0xfff0f0f0);
  Color textColor = Get.isDarkMode ? Colors.white : Colors.black;
  Color imageColor = Get.isDarkMode ? Colors.white : Colors.black;
  Color progressColor = Get.isDarkMode ? Colors.white : Colors.black;

  return Container(
    height: 122,
    width: 343,
    margin: const EdgeInsets.symmetric(vertical: 10),
    padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(
      color: containerColor,
      borderRadius: const BorderRadius.all(Radius.circular(20)),
    ),
    child: Theme(
      data: ThemeData.dark(),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, left: 16),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                        color: textColor,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0, left: 8),
                    child: Text(
                      data,
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 7.0, left: 16),
                    child: Container(
                      width: 229,
                      height: 16,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        child: LinearProgressBar(
                          maxSteps: maxSteps,
                          minHeight: 16,
                          progressType: LinearProgressBar
                              .progressTypeLinear, // Use Linear progress
                          currentStep: currentSteps,
                          progressColor: progressColor,
                          backgroundColor: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 120.0, top: 7),
                        child: Text(
                          data,
                          style: TextStyle(
                            color: textColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Text(
                        "Goal: 1000",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Nunito-VariableFont_wght',
                          fontSize: 10,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 15.0,
              left: 21,
            ),
            child: Image.asset(
              image,
              color: imageColor,
            ),
          ),
        ],
      ),
    ),
  );
}
