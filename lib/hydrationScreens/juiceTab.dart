import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/juiceModel.dart';
import 'package:fitness_app_flutter/model/liquidModel.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';
import '../model/coffeModel.dart';
import '../model/hydration-model.dart/hydration_model.dart';
import '../model/teaModel.dart';
import '../repository/sharedPref/hydration_logic.dart';
import '../utils/snakbar.dart';

class JuiceTabScreen extends StatefulWidget {
  const JuiceTabScreen({Key? key}) : super(key: key);

  @override
  State<JuiceTabScreen> createState() => _JuiceTabScreenState();
}

class _JuiceTabScreenState extends State<JuiceTabScreen> {
  int _selectedIndex = 0;
  int _selectedIndexx = 0;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onSelectedtwo(int index) {
    setState(() => _selectedIndexx = index);
  }

  JuiceModel juiceModel = JuiceModel();
  var liquidType = "fresh";
  var quantity = 250;
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            font18Textbold(text: "Type of liquid"),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      juiceModel.juiceModelData.length,
                      (index) => juiceModel.juiceModelData[index]["title"] !=
                              null
                          ? InkWell(
                              onTap: () {
                                _onSelected(index);
                                liquidType =
                                    juiceModel.juiceModelData[index]["title"];
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                alignment: Alignment.center,
                                height: 35,
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? themeColor
                                      : whitecolor,
                                ),
                                child: font14Textnormal(
                                  text: juiceModel.juiceModelData[index]
                                      ["title"],
                                  color: _selectedIndex != null &&
                                          _selectedIndex == index
                                      ? whitecolor
                                      : blackcolor,
                                ),
                              ),
                            )
                          : const SizedBox()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      juiceModel.juiceModelData.length,
                      (index) => InkWell(
                            onTap: () {
                              _onSelectedtwo(index);
                              quantity =
                                  juiceModel.juiceModelData[index]["amount"];
                              print(quantity);
                            },
                            child: Container(
                              margin: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              height: 65,
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: _selectedIndexx != null &&
                                        _selectedIndexx == index
                                    ? themeColor
                                    : whitecolor,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    juiceModel.juiceModelData[index]["img"],
                                    height: 30,
                                    color: _selectedIndexx != null &&
                                            _selectedIndexx == index
                                        ? whitecolor
                                        : blackcolor,
                                  ),
                                  font14Textnormal(
                                    text: juiceModel.juiceModelData[index]
                                                ["amount"]
                                            .toString() +
                                        " ml",
                                    color: _selectedIndexx != null &&
                                            _selectedIndexx == index
                                        ? whitecolor
                                        : blackcolor,
                                  ),
                                ],
                              ),
                            ),
                          )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: controller,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Add Custom ml",
                ),
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomButton(
                    buttonText: "Add",
                    onTap: () {
                      print(controller.value);
                    
                        var data = {
                          "liquid": "Juice",
                          "liquietype": liquidType,
                          "quantity": controller.text.isNotEmpty?int.parse(controller.text): quantity,
                          "date":
                              DateFormat.yMMMMd('en_US').format(DateTime.now()),
                        };
                        HydrationModel model = HydrationModel.fromJson(data);
                        controller.clear();
                        HydrationLogic.addHydrationLogic(
                            model, "hydration", context);
                      
                    },
                    color: themeColor))
          ],
        ),
      ),
    );
  }
}
