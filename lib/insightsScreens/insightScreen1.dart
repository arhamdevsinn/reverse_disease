import 'dart:developer';

import 'package:fitness_app_flutter/constants/strings.dart';
import 'package:flutter/material.dart';

class CustomStoryView extends StatefulWidget {
  List? data;

  CustomStoryView({super.key,this.data});

  @override
  _CustomStoryViewState createState() => _CustomStoryViewState();
}

class _CustomStoryViewState extends State<CustomStoryView>
    with SingleTickerProviderStateMixin {
  final List _colorsList = [
    Colors.blue,
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.grey,
    Colors.brown
  ];
  final PageController _controller = PageController();
  double? _progressIndicators;
  int _page = 0;
  AnimationController? _animationController;
  bool dragEnded = true;
  Size? _pageSize;
  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 2));
    _animationController!.addListener(animationListener);
    _animationController!.forward();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _pageSize = MediaQuery.of(context).size;
      _progressIndicators = (_pageSize!.width - 100) / widget.data!.length;
    });
    super.initState();
  }

  @override
  void dispose() {
    _animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
    //  floatingActionButton: FloatingActionButton(
    //   onPressed: (){
    //     log(" 0101 ${widget.data![0]["Dics"]}");
    //   },
    //  ),
      body: Stack(
        children: [
          PageView.builder(
            
            controller: _controller,
            physics:const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
               var actualData= widget.data![index];
              return GestureDetector(
              onLongPressStart: _onLongPressStart,
              onLongPressEnd: _onLongPressEnd,
              onHorizontalDragEnd: _onHorizontalDragEnd,
              onHorizontalDragStart: _onHorizontalDragStart,
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              onTapUp: _onTapDown,
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: insightsColor[0],
                child: Center(
                  child: InkWell(
                      onTap: () {
                        print("thiswasclicked $index");
                      },
                      child:  Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // if(actualData["title"]!="${index+1}.")
                            Text(
                             actualData["title"] ,
                              style:const TextStyle(fontSize: 36,fontWeight: FontWeight.w900),
                            ),
                           const SizedBox(height: 20,),
                              Text(
                             actualData["Dics"] ??"",
                              style:const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      )),
                ),
              ),
            );},
            itemCount:widget.data!.length,
          ),
          Positioned(
            top: 48,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: ([
                for(int i=0;i<widget.data!.length;i++)
                i,
                               
              ]
                  .map((e) => (e == _page)
                      ? Stack(
                          children: [
                            Container(
                              width: _progressIndicators,
                              height: 3,
                              color: Colors.black54,
                              // color: Colors.red,
                            ),
                            AnimatedBuilder(
                              animation: _animationController!,
                              builder: (ctx, widget) {
                                return AnimatedContainer(
                                  width: _progressIndicators! *
                                      _animationController!.value,
                                  height: 3,
                                  color: Colors.white,
                                  duration: Duration(milliseconds: 100),
                                );
                              },
                            ),
                          ],
                        )
                      : Container(
                          width: _progressIndicators,
                          height: 3,
                          color: (_page >= e) ? Colors.white : Colors.black54,
                        ))
                  .toList()),
            ),
          )
      
        ],
      ),
    
    );
  }

  animationListener() {
    if (_animationController!.value == 1) {
      _moveForward();
    }
  }

  _moveBackward() {
    if (_controller.page != 0) {
      setState(() {
        _page = (_controller.page! - 1).toInt();
        _page = (_page < 0) ? 0 : _page;
        _controller.animateToPage(_page,
            duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        _animationController!.reset();
        _animationController!.forward();
      });
    }
  }

  _moveForward() {
    if (_controller.page != (_colorsList.length - 1)) {
      setState(() {
        _page = (_controller.page! + 1).toInt();
        _controller.animateToPage(_page,
            duration: Duration(milliseconds: 100), curve: Curves.easeIn);
        _animationController!.reset();
        _animationController!.forward();
      });
    }
  }

  _onTapDown(TapUpDetails details) {
    var x = details.globalPosition.dx;
    (x < _pageSize!.width / 2) ? _moveBackward() : _moveForward();
  }

  _onHorizontalDragUpdate(d) {
    if (!dragEnded) {
      dragEnded = true;
      if (d.delta.dx < -5) {
        _moveForward();
      } else if (d.delta.dx > 5) {
        _moveBackward();
      }
    }
  }

  _onHorizontalDragStart(d) {
    dragEnded = false;
  }

  _onHorizontalDragEnd(d) {
    dragEnded = true;
  }

  _onLongPressEnd(_) {
    _animationController!.forward();
  }

  _onLongPressStart(_) {
    _animationController!.stop();
  }
}
