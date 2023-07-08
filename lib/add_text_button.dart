import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AddTextButton extends StatelessWidget {
  final FocusNode focusNode;
  final Function reRenderState;
  final VideoPlayerController videoController;
  const AddTextButton({
    super.key,
    required this.focusNode,
    required this.reRenderState,
    required this.videoController,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      top: 30,
      child: IconButton(
        icon: Icon(Icons.text_fields),
        color: Colors.black,
        iconSize: 30,
        style: IconButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          focusNode.requestFocus();
          reRenderState();
        },
      ),
    );
  }
}
