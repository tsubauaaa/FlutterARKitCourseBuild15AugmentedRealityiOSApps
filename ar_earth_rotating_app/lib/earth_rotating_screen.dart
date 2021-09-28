import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'dart:async';
import 'package:vector_math/vector_math_64.dart';

class EarthRotatingScreen extends StatefulWidget {
  const EarthRotatingScreen({Key? key}) : super(key: key);

  @override
  _EarthRotatingScreenState createState() => _EarthRotatingScreenState();
}

class _EarthRotatingScreenState extends State<EarthRotatingScreen> {
  ARKitController? _arKitController;
  Timer? timer;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: ARKitSceneView(
            onARKitViewCreated: createARKitView,
          ),
        ),
      );

  void createARKitView(ARKitController arKitController) {
    _arKitController = arKitController;

    final material = ARKitMaterial(
      lightingModelName: ARKitLightingModel.lambert,
      diffuse: ARKitMaterialProperty.image('earth.jpg'),
    );

    final sphere = ARKitSphere(
      materials: [material],
      radius: 0.1,
    );

    final node = ARKitNode(
      geometry: sphere,
      position: Vector3(0, 0, -0.5),
      eulerAngles: Vector3.zero(),
    );
    _arKitController!.add(node);

    timer = Timer.periodic(
      const Duration(milliseconds: 30),
      (timer) {
        final rotation = node.eulerAngles;
        rotation.x += 0.01;
        node.eulerAngles = rotation;
      },
    );
  }
}
