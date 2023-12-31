import 'dart:io';

import 'package:flutter/material.dart';

import 'package:file_picker/file_picker.dart';
import 'package:matrix_gesture_detector/matrix_gesture_detector.dart';
import 'package:sgr_project/add_text_button.dart';
import 'package:sgr_project/on_video_textfield.dart';
import 'package:sgr_project/scalable_text.dart';
import 'package:video_player/video_player.dart';
import 'package:camera/camera.dart';

Future<void> main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

// Get a specific camera from the list of available cameras.
  final CameraDescription firstCamera = cameras.first;

  runApp(MyApp(
    camera: firstCamera,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.camera});

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(camera: camera),
    );
  }
}

//

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.camera});

  // final String title;
  final CameraDescription camera;
  // VideoWatermark _textWatermark;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File file = File('path');
  late VideoPlayerController _videoController;
  List<TextEditingController> _textControllers = [];
  FocusNode _focusNode = FocusNode();
  double scale = 0.0;
  // final ValueNotifier<Matrix4> notifier1 = ValueNotifier(Matrix4.identity());
  // final ValueNotifier<Matrix4> notifier2 = ValueNotifier(Matrix4.identity());
  // List<ValueNotifier<Matrix4>> _notifiers = [
  //   ValueNotifier(Matrix4.identity()),
  //   ValueNotifier(Matrix4.identity()),
  //   ValueNotifier(Matrix4.identity()),
  // ];
  List<ValueNotifier<Matrix4>> _notifiers = [];
  bool _finishedTyping = false;
  List<Color> _colors = [
    Colors.red,
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.blue,
    Colors.purple,
    Colors.pink,
    Colors.grey,
  ];

  void InvertBoolToAddFirstText() {
    _notifiers.add(ValueNotifier(Matrix4.identity()));
    _textControllers.add(TextEditingController());
    setState(() {
      _finishedTyping = true;
    });
  }

  void InvertBoolToAddSecondText() {
    setState(() {
      _finishedTyping = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _videoController = VideoPlayerController.file(file);
    _videoController.play();
    _videoController.setLooping(true);
    _videoController.initialize().then((value) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoController.dispose();
    _textControllers.forEach((element) => element.dispose());
    _focusNode.dispose();
  }

  Future<void> _chooseVideoToPlay() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = File(result.files.single.path!);
      _videoController = VideoPlayerController.file(file);
      _videoController.play();
      _videoController.setLooping(true);
      _videoController.initialize().then((value) {
        setState(() {});
      });
    _textControllers.add(TextEditingController());
    } else {}
    _videoController.play();
  }


  @override
  Widget build(BuildContext context) {
    print(_textControllers.length);
    _videoController.setLooping(true);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Center(
            child: !_videoController.value.isPlaying
                ? TextButton(
                    child: const Text('press me'),
                    onPressed: () async {
                      _chooseVideoToPlay();
                    },
                  )
                : _videoController.value.isInitialized
                    ? Expanded(
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            VideoPlayer(_videoController),
                            AddTextButton(
                                focusNode: _focusNode,
                                reRenderState: InvertBoolToAddSecondText,
                                videoController: _videoController),
                            if (!_finishedTyping)
                              OnVideoTextField(
                                  textControllers: _textControllers,
                                  focusNode: _focusNode,
                                  videoController: _videoController,
                                  finishedTyping: _finishedTyping,
                                  reRenderState: InvertBoolToAddFirstText)
                            else
                              for (int i = 0; i<_notifiers.length; i++)
                                Positioned.fill(
                                  child: ScalableText(
                                      textController: _textControllers[i],
                                      notifier: _notifiers[i]),
                                )
                          ],
                        ),
                      )
                    : Container()),
      ),
    );
  }
}
