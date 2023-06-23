import 'package:flutter/material.dart';

class AddTextButton extends StatelessWidget {
  final FocusNode focusNode;
  const AddTextButton({super.key, required this.focusNode});

  @override
  Widget build(BuildContext context) {
    return Positioned(
                              right: 20,
                              top: 30,
                              child: IconButton(
                                icon: Icon(Icons.text_fields),
                                color: Colors.black,
                                iconSize: 30,
                                style: IconButton.styleFrom(
                                    backgroundColor: Colors.white),
                                onPressed: () {
                                  focusNode.requestFocus();
                                },
                              ),
                            );
  }
}