import 'package:flutter/material.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';

class SC extends StatefulWidget {
  final TextEditingController textController;
  final ValueNotifier<Matrix4> notifier;
  const SC(
      {super.key, required this.textController, required this.notifier});

  @override
  State<SC> createState() => _SCState();
}

class _SCState extends State<SC> {
  @override
  Widget build(BuildContext context) {
    return MatrixGestureDetector(
      onMatrixUpdate: (m, tm, sm, rm) {
        widget.notifier.value = m;
      },
      child: AnimatedBuilder(
        animation: widget.notifier,
        builder: (ctx, child) {
          return Transform(
            transform: widget.notifier.value,
            child: Center(
              child: Stack(
                children: <Widget>[
                  Container(
                    color: Colors.transparent,
                    child: Transform.scale(
                      scale:
                          1, // make this dynamic to change the scaling as in the basic demo
                      origin: Offset(0.0, 0.0),
                      child: Container(
                        color: Colors.blue,
                        height: 100,
                        width: 100,
                        child: Center(
                          child: Text(
                            widget.textController.text,
                            style: const TextStyle(
                                fontSize: 26, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
