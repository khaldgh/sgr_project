import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnVideoTextField extends StatefulWidget {
  final List<TextEditingController> textControllers;
  final FocusNode focusNode;
  final VideoPlayerController videoController;
  final bool finishedTyping;
  final Function reRenderState;
  const OnVideoTextField(
      {super.key,
      required this.textControllers,
      required this.focusNode,
      required this.videoController,
      required this.finishedTyping,
      required this.reRenderState});

  @override
  State<OnVideoTextField> createState() => _OnVideoTextFieldState();
}

class _OnVideoTextFieldState extends State<OnVideoTextField> {
  int i = 0;
  @override
  Widget build(BuildContext context) {
    int index = i;
    print({'I AM index $index'});
    return Positioned(
      left: 0,
      right: 0,
      top: 150,
      child: TextField(
        controller: index == 0 ? widget.textControllers[index] : widget.textControllers[index] ,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            shadows: [Shadow(color: Colors.white, offset: Offset(0.5, 0.5))]),
        decoration: InputDecoration(border: InputBorder.none),
        onEditingComplete: () {
           index++;
          widget.focusNode.unfocus();
            widget.reRenderState();
        },
      ),
    );
  }
}
