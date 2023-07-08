import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class OnVideoTextField extends StatefulWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final VideoPlayerController videoController;
  final bool finishedTyping;
  final Function reRenderState;
  const OnVideoTextField(
      {super.key,
      required this.textController,
      required this.focusNode,
      required this.videoController,
      required this.finishedTyping,
      required this.reRenderState});

  @override
  State<OnVideoTextField> createState() => _OnVideoTextFieldState();
}

class _OnVideoTextFieldState extends State<OnVideoTextField> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      top: 150,
      child: TextField(
        controller: widget.textController,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            shadows: [Shadow(color: Colors.white, offset: Offset(0.5, 0.5))]),
        decoration: InputDecoration(border: InputBorder.none),
        onEditingComplete: () {
          widget.focusNode.unfocus();
            widget.reRenderState();
        },
      ),
    );
  }
}
