import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/alcoholModel.dart';
import 'package:fitness_app_flutter/widgets/customButton.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../constants/colors.dart';
import '../model/hydration-model.dart/hydration_model.dart';
import '../repository/sharedPref/hydration_logic.dart';
import '../utils/snakbar.dart';

class AlcoholTabScreen extends StatefulWidget {
  const AlcoholTabScreen({Key? key}) : super(key: key);

  @override
  State<AlcoholTabScreen> createState() => _AlcoholTabScreenState();
}

class _AlcoholTabScreenState extends State<AlcoholTabScreen> {
  int _selectedIndex = 0;
  int _selectedIndexx = 0;
  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  _onSelectedtwo(int index) {
    setState(() => _selectedIndexx = index);
  }

  AlcoholModel alcoholModel = AlcoholModel();
  var liquidType = "Beer";
  var quantity = 350;
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
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      alcoholModel.alcoholModelData.length,
                      (index) => InkWell(
                            onTap: () { _onSelected(index);
                            liquidType= alcoholModel.alcoholModelData[index]
                                    ["title"];
                                    print(liquidType);
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
                                text: alcoholModel.alcoholModelData[index]
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
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                      alcoholModel.alcoholModelData.length,
                      (index) => alcoholModel.alcoholModelData[index]
                                  ["amount"] !=
                              null
                          ? InkWell(
                              onTap: () { _onSelectedtwo(index);
                              quantity= alcoholModel.alcoholModelData[index]
                                          ["amount"];
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
                                      alcoholModel.alcoholModelData[index]
                                          ["img"],
                                      height: 30,
                                      color: _selectedIndexx != null &&
                                              _selectedIndexx == index
                                          ? whitecolor
                                          : blackcolor,
                                    ),
                                    font14Textnormal(
                                      text: "${alcoholModel.alcoholModelData[index]
                                          ["amount"]} ml",
                                      color: _selectedIndexx != null &&
                                              _selectedIndexx == index
                                          ? whitecolor
                                          : blackcolor,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SizedBox()),
                ),
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
                    buttonText: "Add", onTap: () {
                       
                         var data = {
                        "liquid": "Alcohol",
                        "liquietype": liquidType,
                        "quantity": controller.text.isNotEmpty?int.parse(controller.text): quantity,
                        "date":
                            DateFormat.yMMMMd('en_US').format(DateTime.now()),
                      };
                      HydrationModel model = HydrationModel.fromJson(data);

                      HydrationLogic.addHydrationLogic(
                          model, "hydration", context);
                        
                      
                    }, color: themeColor))
          ],
        ),
      ),
    );
  }
}
