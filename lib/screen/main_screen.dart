import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../controller/calculate_controller.dart';
import '../widget/button.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final List<String> buttons = [
    "C",
    "",
    "DEL",
    "/",
    "7",
    "8",
    "9",
    "x",
    "4",
    "5",
    "6",
    "-",
    "1",
    "2",
    "3",
    "+",
    "",
    "0",
    ".",
    "=",
  ];

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CalculateController>();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        children: [
          GetBuilder<CalculateController>(builder: (context) {
            return outPutSection(controller);
          }),
          inPutSection(controller),
        ],
      ),
    );
  }

  /// In put Section - Enter Numbers
  Expanded inPutSection(CalculateController controller) {
    return Expanded(
        flex: 2,
        child: Container(
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            border: Border(
              top: BorderSide(color: Colors.grey.shade200, width: 1),
            ),
          ),
          child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4),
              itemBuilder: (context, index) {
                switch (index) {

                /// CLEAR BTN
                  case 0:
                    return CustomButton(
                        buttonTapped: () {
                          controller.clearInputAndOutput();
                        },
                        color: Color.fromARGB(255, 255, 255, 255),
                        textColor: Color.fromRGBO(255, 136, 125, 1),
                        text: buttons[index]);

                /// DELETE BTN
                  case 2:
                    return CustomButton(
                        buttonTapped: () {
                          controller.deleteBtnAction();
                        },
                        color: Color.fromARGB(255, 255, 255, 255),
                        textColor: Color.fromRGBO(17, 153, 142, 1),
                        text: buttons[index]);

                /// EQUAL BTN
                  case 19:
                    return CustomButton(
                        buttonTapped: () {
                          controller.equalPressed();
                        },
                        color: const Color.fromARGB(255, 12, 142, 131),
                        textColor: const Color.fromARGB(255, 255, 255, 255),
                        text: buttons[index]);

                  default:
                    return CustomButton(
                        buttonTapped: () {
                          controller.onBtnTapped(buttons, index);
                        },
                        color: Color.fromARGB(255, 255, 255, 255),
                        textColor: isOperator(buttons[index])
                            ? Color.fromRGBO(17, 153, 142, 1)
                            : Colors.grey,
                        text: buttons[index]);
                }
              }),
        ));
  }

  /// Out put Section - Show Result
  Expanded outPutSection(CalculateController controller) {
    return Expanded(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                padding: EdgeInsets.only(top:47),
                alignment: Alignment.topCenter,
                child: Text(
                  "Calculator",
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.7),
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
              padding: const EdgeInsets.only(right: 30, top: 70),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      controller.userInput,
                      style: const TextStyle(color: Colors.grey, fontSize: 48),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    alignment: Alignment.bottomRight,
                    child: Text(controller.userOutput,
                        style: const TextStyle(color: Colors.grey, fontSize: 48)),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  ///
  bool isOperator(String y) {
    if (y == "%" || y == "/" || y == "x" || y == "-" || y == "+" || y == "=") {
      return true;
    }
    return false;
  }
}
