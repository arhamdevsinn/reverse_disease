// import 'package:fitness_app_flutter/constants/colors.dart';
// import 'package:fitness_app_flutter/constants/strings.dart';
// import 'package:fitness_app_flutter/widgets/customButton.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';

// class FastingHourScreen extends StatefulWidget {
//   const FastingHourScreen({Key? key}) : super(key: key);

//   @override
//   State<FastingHourScreen> createState() => _FastingHourScreenState();
// }

// class _FastingHourScreenState extends State<FastingHourScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: SingleChildScrollView(
//             child: Column(
//           children: [
//             Container(
//               width: MediaQuery.of(context).size.width,
//               color: fastingProtocolColors[0],
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const BackButton(),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 15, vertical: 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Expanded(
//                                 child: Text(
//                                   "14:10",
//                                   style: TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Image.asset(
//                                   "images/timer.png",
//                                   height: 80,
//                                 ),
//                               )
//                             ],
//                           ),
//                           SizedBox(height: 10),
//                           Text(
//                             "Fasting protocol",
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(height: 20),
//                           Text(
//                             "Initial & basic TRF - a basic, easy-to-follow type of IF. Try it if your are a beginner or do not feel comfortable during the classic 16:8 type. Helps adapt your body to longer fasting",
//                             style: TextStyle(
//                               fontSize: 18,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             const SizedBox(height: 20),
//             Container(
//               margin: const EdgeInsets.all(10),
//               height: 130,
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(10),
//                   color: const Color.fromARGB(255, 208, 245, 245)),
//               child: Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Column(
//                   children: [
//                     Row(
//                       children: [
//                         const CircleAvatar(
//                           backgroundColor: Colors.white,
//                           backgroundImage: AssetImage("images/logo.png"),
//                         ),
//                         const SizedBox(width: 10),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: const [
//                             Text(
//                               "Poonam Dua",
//                               style: TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             SizedBox(height: 2),
//                             Text("Registered Dietitian")
//                           ],
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 10),
//                     const Text(
//                       "Suitable for beginners who are new to intermittent fasting",
//                       style: TextStyle(fontSize: 16),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: 20),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: const [
//                   Text(
//                     "Food recommendations",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(height: 10),
//                   Text(
//                     "Eat every 3-4 hours daily the eating window. Focus on whole foods, limit or exclude junk food",
//                     style: TextStyle(
//                       fontSize: 18,
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
//               child: CustomButton(
//                   buttonText: "Choose this protocol",
//                   onTap: () {},
//                   color: themeColor),
//             )
//           ],
//         )),
//       ),
//     );
//   }
// }
