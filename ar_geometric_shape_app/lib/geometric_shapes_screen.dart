import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

class GeometricShapesScreen extends StatefulWidget {
  const GeometricShapesScreen({Key? key}) : super(key: key);

  @override
  _GeometricShapesScreenState createState() => _GeometricShapesScreenState();
}

class _GeometricShapesScreenState extends State<GeometricShapesScreen> {
  ARKitController? _arKitController;

  List<ARKitMaterial> _createRandomColorMaterial() {
    return [
      ARKitMaterial(
        lightingModelName: ARKitLightingModel.physicallyBased,
        diffuse: ARKitMaterialProperty.color(
          Color((math.Random().nextDouble() * 0xFFFFFF).toInt() << 0)
              .withOpacity(1.0),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
    _arKitController?.dispose();
  }

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

    _arKitController!.add(_createSphere());
    _arKitController!.add(_createBox());
    _arKitController!.add(_createCylinder());
    _arKitController!.add(_createCone());

    _arKitController!.add(_createPyramid());
    _arKitController!.add(_createTube());
    _arKitController!.add(_createTorus());
    _arKitController!.add(_createCapsule());
  }

  // create sphere
  ARKitNode _createSphere() => ARKitNode(
        geometry: ARKitSphere(
          materials: _createRandomColorMaterial(),
          radius: 0.04,
        ),
        position: vector.Vector3(-0.1, -0.1, -0.5),
      );

  // create box
  ARKitNode _createBox() => ARKitNode(
        geometry: ARKitBox(
          width: 0.06,
          height: 0.06,
          length: 0.06,
          chamferRadius: 0.01,
          materials: _createRandomColorMaterial(),
        ),
        position: vector.Vector3(-0.1, 0, -0.5),
      );

  // create cylinder
  ARKitNode _createCylinder() => ARKitNode(
        geometry: ARKitCylinder(
          radius: 0.05,
          height: 0.06,
          materials: _createRandomColorMaterial(),
        ),
        position: vector.Vector3(-0.1, 0.1, -0.5),
      );

  // create cone
  ARKitNode _createCone() => ARKitNode(
        geometry: ARKitCone(
          topRadius: 0,
          bottomRadius: 0.05,
          height: 0.09,
          materials: _createRandomColorMaterial(),
        ),
        position: vector.Vector3(0, -0.1, -0.5),
      );

  // create pyramid
  ARKitNode _createPyramid() => ARKitNode(
        geometry: ARKitPyramid(
          width: 0.09,
          height: 0.09,
          length: 0.09,
          materials: _createRandomColorMaterial(),
        ),
        position: vector.Vector3(0, -0.05, -0.5),
      );

  // create tube
  ARKitNode _createTube() => ARKitNode(
        geometry: ARKitTube(
          innerRadius: 0.03,
          outerRadius: 0.05,
          height: 0.09,
          materials: _createRandomColorMaterial(),
        ),
        position: vector.Vector3(0.1, 0.1, -0.5),
      );

  // create torus
  ARKitNode _createTorus() => ARKitNode(
        geometry: ARKitTorus(
          ringRadius: 0.04,
          pipeRadius: 0.02,
          materials: _createRandomColorMaterial(),
        ),
        position: vector.Vector3(0.1, -0.1, -0.5),
      );

  // create capsule
  ARKitNode _createCapsule() => ARKitNode(
        geometry: ARKitCapsule(
          capRadius: 0.02,
          height: 0.06,
          materials: _createRandomColorMaterial(),
        ),
        position: vector.Vector3(0.1, 0, -0.5),
      );
}
