import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/constants/textHelper.dart';
import 'package:fitness_app_flutter/model/fastingModel/fasting_model.dart';
import 'package:fitness_app_flutter/repository/fastingPref/fasting_history_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FastingDetails extends StatefulWidget {
  const FastingDetails({Key? key}) : super(key: key);

  @override
  State<FastingDetails> createState() => _FastingDetailsState();
}

class _FastingDetailsState extends State<FastingDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whitecolor,
      appBar: AppBar(
        backgroundColor: whitecolor,
        elevation: 0.0,
        leading: const BackButton(
          color: blackcolor,
        ),
      ),
      body: FutureBuilder<List>(
          future: FastingHistoryPref.readFastingHistory("fastingHistory"),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            print(snapshot.data);
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: font28Textbold(text: "Fasting History"),
                  ),
                  Column(
                      children: List.generate(
                    snapshot.data!.length,
                    (index) {
                        FastingHistoryModel model=FastingHistoryModel.fromJson(snapshot.data![index]);
                      return Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (val) async {
                              snapshot.data!.removeAt(index);
                              FastingHistoryPref.saveFastingHistory(snapshot.data, "fastingHistory");
                              setState(() {
                                
                              });
                            },
                            backgroundColor: themeColor,
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 80,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                   Text("${model.fastingDuration}",style:
                                    const TextStyle(fontWeight: FontWeight.bold),),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                    Text("${
                                      model.startFast} ",
                                      style: TextStyle(color: Colors.grey.shade600,fontSize: 16.0),
                                    ),
                                   const SizedBox(height: 10,),
                                    Text("${
                                      model.endFast} ",
                                      style:const TextStyle(color: Colors.black,fontSize: 16.0),
                                    ),
                              ],
                                    )
                                 
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                              height: 2,
                              child: Divider(
                                thickness: 1,
                                color: Colors.grey,
                              ))
                        ],
                      ),
                    );}
                  )),
                ]);
          }),
    );
  }
}
