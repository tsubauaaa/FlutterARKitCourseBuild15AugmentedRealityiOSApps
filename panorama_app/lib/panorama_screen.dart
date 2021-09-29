import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class PanoramaScreen extends StatefulWidget {
  const PanoramaScreen({Key? key}) : super(key: key);

  @override
  _PanoramaScreenState createState() => _PanoramaScreenState();
}

class _PanoramaScreenState extends State<PanoramaScreen> {
  ARKitController? _arKitController;

  @override
  void dispose() {
    _arKitController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Panorama App'),
        ),
        body: Container(
          child: ARKitSceneView(
            onARKitViewCreated: onARViewCreated,
          ),
        ),
      );

  void onARViewCreated(ARKitController arKitController) {
    _arKitController = arKitController;
    final material = ARKitMaterial(
      diffuse: ARKitMaterialProperty.image('photo360.jpg'),
      doubleSided: true,
    );

    final sphere = ARKitSphere(
      materials: [material],
      radius: 1,
    );

    final node = ARKitNode(
      geometry: sphere,
      position: vector.Vector3.zero(),
    );

    _arKitController?.add(node);
  }
}
