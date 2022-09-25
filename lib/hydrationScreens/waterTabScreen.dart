import 'dart:developer';
import 'dart:ffi';

import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/hydration-model.dart/hydration_model.dart';
import 'package:fitness_app_flutter/model/liquidModel.dart';
import 'package:fitness_app_flutter/repository/sharedPref/hydration_logic.dart';
import 'package:fitness_app_flutter/repository/sharedPref/shared_pref.dart';
import 'package:fitness_app_flutter/utils/snakbar.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import '../constants/colors.dart';

class WaterTabScreen extends StatefulWidget {
  final String? type;
  const WaterTabScreen({Key? key, this.type}) : super(key: key);

  @override
  State<WaterTabScreen> createState() => _WaterTabScreenState();
}

class _WaterTabScreenState extends State<WaterTabScreen> {
  int _selectedIndex = 0;
  int _selectedIndexx = 0;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onSelectedtwo(int index) {
    setState(() => _selectedIndexx = index);
  }

  TypeLiquidModel typeLiquidModel = TypeLiquidModel();
  LiquidModel liquidModel = LiquidModel();
  var liquidType="regular";
  var quantity =200;
  TextEditingController controller=TextEditingController();
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    typeLiquidModel.typeliquidModelData.length,
                    (index) => InkWell(
                          onTap: () {
                            _onSelected(index);
                            liquidType = typeLiquidModel
                                .typeliquidModelData[index]["title"];
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 35,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? themeColor
                                  : whitecolor,
                            ),
                            child: font14Textnormal(
                              text: typeLiquidModel.typeliquidModelData[index]
                                  ["title"],
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? whitecolor
                                  : blackcolor,
                            ),
                          ),
                        )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                    liquidModel.liquidModelData.length,
                    (index) => InkWell(
                          onTap: () {
                            _onSelectedtwo(index);
                            quantity =
                                liquidModel.liquidModelData[index]["amount"];
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 65,
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: _selectedIndexx != null &&
                                      _selectedIndexx == index
                                  ? themeColor
                                  : whitecolor,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.asset(
                                  liquidModel.liquidModelData[index]["img"],
                                  height: 30,
                                  color: _selectedIndexx != null &&
                                          _selectedIndexx == index
                                      ? whitecolor
                                      : blackcolor,
                                ),
                                font14Textnormal(
                                  text: liquidModel.liquidModelData[index]
                                      ["amount"].toString()+" ml",
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: TextFormField(
                controller: controller,
              keyboardType:TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Add Custom ml",
                ),
                
                
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(top: 30),
                child: CustomButton(
                    buttonText: "Add",
                    onTap: () async {
                 
                      var data = {
                        "liquid": widget.type,
                        "liquietype": liquidType,
                        "quantity":controller.text.isNotEmpty?int.parse(controller.text): quantity,
                        "date":
                            DateFormat.yMMMMd('en_US').format(DateTime.now()),
                      };
                      HydrationModel model = HydrationModel.fromJson(data);
                    controller.clear();
                      HydrationLogic.addHydrationLogic(model, "hydration",context);
                      // HydrationPreferences.deleteData();
                    },
                    color: themeColor))
          ],
        ),
      ),
    );
  }
}
