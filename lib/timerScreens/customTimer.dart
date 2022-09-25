// import 'package:flutter/material.dart';
// import 'package:stop_watch_timer/stop_watch_timer.dart';

// class CountUpTimerPage extends StatefulWidget {
//   static Future<void> navigatorPush(BuildContext context) async {
//     return Navigator.push<void>(
//       context,
//       MaterialPageRoute(
//         builder: (_) => CountUpTimerPage(),
//       ),
//     );
//   }

//   @override
//   _State createState() => _State();
// }

// class _State extends State<CountUpTimerPage> {
//   final _isHours = true;

//   final StopWatchTimer _stopWatchTimer = StopWatchTimer(
//     mode: StopWatchMode.countUp,
//     onChange: (value) => print('onChange $value'),
//     onChangeRawSecond: (value) => print('onChangeRawSecond $value'),
//     onChangeRawMinute: (value) => print('onChangeRawMinute $value'),
//     onStop: () {
//       print('onStop');
//     },
//     onEnded: () {
//       print('onEnded');
//     },
//   );

//   final _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     _stopWatchTimer.rawTime.listen((value) =>
//         print('rawTime $value ${StopWatchTimer.getDisplayTime(value)}'));
//     _stopWatchTimer.minuteTime.listen((value) => print('minuteTime $value'));
//     _stopWatchTimer.secondTime.listen((value) => print('secondTime $value'));
//     _stopWatchTimer.records.listen((value) => print('records $value'));
//     _stopWatchTimer.fetchStop.listen((value) => print('stop from stream'));
//     _stopWatchTimer.fetchEnded.listen((value) => print('ended from stream'));

//     /// Can be set preset time. This case is "00:01.23".
//     // _stopWatchTimer.setPresetTime(mSec: 1234);
//   }

//   @override
//   void dispose() async {
//     super.dispose();
//     await _stopWatchTimer.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('CountUp Sample'),
//       ),
//       body: Scrollbar(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(
//               vertical: 32,
//               horizontal: 16,
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 /// Display stop watch time
//                 StreamBuilder<int>(
//                   stream: _stopWatchTimer.rawTime,
//                   initialData: _stopWatchTimer.rawTime.value,
//                   builder: (context, snap) {
//                     final value = snap.data!;
//                     final displayTime =
//                         StopWatchTimer.getDisplayTime(value, hours: _isHours);
//                     return Column(
//                       children: <Widget>[
//                         Padding(
//                           padding: const EdgeInsets.all(8),
//                           child: Text(
//                             displayTime,
//                             style: const TextStyle(
//                                 fontSize: 40,
//                                 fontFamily: 'Helvetica',
//                                 fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ],
//                     );
//                   },
//                 ),

//                 /// Button
//                 Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 4),
//                         child: RaisedButton(
//                           padding: const EdgeInsets.all(4),
//                           color: Colors.lightBlue,
//                           shape: const StadiumBorder(),
//                           onPressed: () async {
//                             _stopWatchTimer.onExecute
//                                 .add(StopWatchExecute.start);
//                           },
//                           child: const Text(
//                             'Start',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(horizontal: 4),
//                         child: RaisedButton(
//                           padding: const EdgeInsets.all(4),
//                           color: Colors.green,
//                           shape: const StadiumBorder(),
//                           onPressed: () async {
//                             _stopWatchTimer.onExecute
//                                 .add(StopWatchExecute.stop);
//                           },
//                           child: const Text(
//                             'Stop',
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ])
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
