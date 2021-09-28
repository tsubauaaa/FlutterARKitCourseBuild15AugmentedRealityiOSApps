import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

class PlaneScreen extends StatefulWidget {
  const PlaneScreen({Key? key}) : super(key: key);

  @override
  _PlaneScreenState createState() => _PlaneScreenState();
}

class _PlaneScreenState extends State<PlaneScreen> {
  ARKitController? _arKitController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ARKitSceneView(
          onARKitViewCreated: createARKitView,
        ),
      ),
    );
  }

  void createARKitView(ARKitController arKitController) {
    _arKitController = arKitController;

    _arKitController!.add(createPlane());
  }

  ARKitNode createPlane() {
    final plane = ARKitPlane(
      width: 1,
      height: 1,
      materials: [
        ARKitMaterial(
          transparency: 0.5,
          diffuse: ARKitMaterialProperty.color(Colors.deepPurple),
        ),
      ],
    );
    return ARKitNode(
      geometry: plane,
      position: vector.Vector3(0, 0, -1.5),
    );
  }
}
