import 'package:fitness_app_flutter/constants/colors.dart';
import 'package:fitness_app_flutter/hydrationScreens/hydration_history.dart';
import 'package:fitness_app_flutter/model/hydration-model.dart/hydration_model.dart';
import 'package:fitness_app_flutter/repository/sharedPref/shared_pref.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ShowHistory extends StatefulWidget {
  var liquid;
  var date;
  final totalQuatity;

  ShowHistory({super.key, this.liquid, this.date, this.totalQuatity});

  @override
  State<ShowHistory> createState() => _ShowHistoryState();
}

class _ShowHistoryState extends State<ShowHistory> {

  fetchHydrationQuantity()async{
    quantity = 0;
    var data =  await HydrationPreferences.readHydrationData('hydration');
    for (var e in data) {
      quantity += e['quantity'];
    }
    setState(() {
      // quantity = data.;
    });  

    print(quantity);
    
  }

  num quantity = 0;


  @override
  void initState() {
    fetchHydrationQuantity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
        body: SafeArea(
      child: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              elevation: 0.0,
              snap: true,
              pinned: true,
              floating: true,
            
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text("$quantity ml",
                    style: const TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
                expandedTitleScale: 1.8,
              ),
              expandedHeight: 100,
              backgroundColor: Colors.white24,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                tooltip: 'Menu',
                onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder:(context)=>const HydrationHistory() ));
                },
              ),
            ),
          ];
        },
        body: FutureBuilder<List>(
            future: HydrationPreferences.readHydrationData("hydration2"),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              List showData = [];
              List<int> indexs = [];
              for (int i = 0; i < snapshot.data!.length; i++) {
                if (
                    // (widget.liquid == snapshot.data![i]["liquid"]) &&
                    (widget.date == snapshot.data![i]["date"])) {
                  showData.add(snapshot.data![i]);
                  indexs.add(i);
                }
              }

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  showData.isNotEmpty
                      ? Padding(
                          padding:
                              const EdgeInsets.only(left: 20.0, bottom: 20.0),
                          child: Text(
                            "${widget.date} . ${widget.totalQuatity} ml hydration",
                            style: TextStyle(
                                color: Colors.grey[600], fontSize: 16),
                          ),
                        )
                      : const SizedBox(),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: showData.length,
                    itemBuilder: (context, index) {
                      HydrationModel model =
                          HydrationModel.fromJson(showData[index]);

                      return Slidable(
                        endActionPane: ActionPane(
                          motion: const ScrollMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (val) async {
                                dynamic checkAount;
                                var whicINdex;
                                var data = await HydrationPreferences
                                    .readHydrationData("hydration");

                                for (int i = 0; i < data.length; i++) {
                                  if (
                                    // (model.liquid == data[i]["liquid"]) &&
                                      (model.date == data[i]["date"])) {
                                    checkAount = data[i]["quantity"].toInt() -
                                        model.quantity.toInt();
                                    whicINdex = i;
                                    // getTotalQuantity=getTotalQuantity+data[i]["quatity"];
                                    print(whicINdex);
                                  }
                                }
                                if (checkAount == 0) {
                                  data.removeAt(whicINdex);
                                  await HydrationPreferences.saveHydrationData(
                                      data, "hydration");
                                  showData.removeAt(index);
                                  snapshot.data!.removeAt(indexs[index]);
                                  await HydrationPreferences.saveHydrationData(
                                      snapshot.data, "hydration2");
                                } else {
                                  data[whicINdex]["quantity"] = checkAount;
                                  await HydrationPreferences.saveHydrationData(
                                      data, "hydration");
                                  showData.removeAt(index);
                                  snapshot.data!.removeAt(index);

                                  await HydrationPreferences.saveHydrationData(
                                      snapshot.data, "hydration2");
                                }
                               fetchHydrationQuantity();
                                setState(() {});
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
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${model.liquid},${model.liquietype}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "${model.quantity} ml",
                                      style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 16.0),
                                    ),
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
                      );
                    },
                  ),
                ],
              );
            }),
      ),
    ));
  }
}
