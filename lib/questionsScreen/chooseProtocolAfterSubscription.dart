// import 'package:flutter/material.dart';
// import '../constants/strings.dart';
// import '../constants/textHelper.dart';

// class ChooseFastingProtocolScreenAfterSubc extends StatefulWidget {
//   const ChooseFastingProtocolScreenAfterSubc({Key? key}) : super(key: key);

//   @override
//   State<ChooseFastingProtocolScreenAfterSubc> createState() =>
//       _ChooseFastingProtocolScreenAfterSubcState();
// }

// class _ChooseFastingProtocolScreenAfterSubcState
//     extends State<ChooseFastingProtocolScreen> {
//   @override
//   Widget build(BuildContext context) {
//     List fastingProtocolScreens = [
//       const Fasting14HourScreen(),
//       const Fasting16HourScreen(),
//       const Fasting18HourScreen(),
//       const Fasting20HourScreen(),
//       const Fasting23HourScreen(),
//       const Fasting12to23HourScreen(),
//     ];

//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               const Text(
//                 "Fasting protocols",
//                 style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 10),
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: (1 / 1.4),
//                 ),
//                 itemCount: 6,
//                 itemBuilder: (BuildContext context, int index) {
//                   return InkWell(
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) =>
//                                 fastingProtocolScreens[index]),
//                       );
//                     },
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Container(
//                         padding: const EdgeInsets.all(15),
//                         decoration: BoxDecoration(
//                             color: fastingProtocolColors[index],
//                             borderRadius: BorderRadius.circular(10)),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 Text(
//                                   fastingProtocolHours[index],
//                                   style: const TextStyle(
//                                       fontSize: 24,
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Expanded(
//                                   child: Image.asset(
//                                     "images/timer.png",
//                                     height: 50,
//                                   ),
//                                 )
//                               ],
//                             ),
//                             const Text(
//                               "hour",
//                               style: TextStyle(fontSize: 16),
//                             ),
//                             Text(fastingProtocolDescription[index]),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 font14Textbold(text: "Read more"),
//                                 // ignore: prefer_const_constructors
//                                 Icon(
//                                   Icons.arrow_forward_ios,
//                                   size: 15,
//                                 )
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _settingModalBottomSheet(context) {
//     showModalBottomSheet(
//         context: context,
//         builder: (BuildContext bc) {
//           return Container(
//             child: new Wrap(
//               children: <Widget>[
//                 new ListTile(
//                     leading: new Icon(Icons.music_note),
//                     title: new Text('Music'),
//                     onTap: () => {}),
//                 new ListTile(
//                   leading: new Icon(Icons.videocam),
//                   title: new Text('Video'),
//                   onTap: () => {},
//                 ),
//               ],
//             ),
//           );
//         });
//   }
// }
