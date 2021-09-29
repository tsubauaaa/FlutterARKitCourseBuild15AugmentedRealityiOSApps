import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;

class CustomBirdObjectScreen extends StatefulWidget {
  const CustomBirdObjectScreen({Key? key}) : super(key: key);

  @override
  _CustomBirdObjectScreenState createState() => _CustomBirdObjectScreenState();
}

class _CustomBirdObjectScreenState extends State<CustomBirdObjectScreen> {
  ARKitController? _arKitController;
  ARKitReferenceNode? node;
  String? anchorId;

  @override
  void dispose() {
    super.dispose();
    _arKitController?.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: createARView,
          ),
        ),
      );

  void createARView(ARKitController arKitController) {
    _arKitController = arKitController;
    _arKitController?.onAddNodeForAnchor = handleAddAnchor;
  }

  void handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is ARKitPlaneAnchor) {
      addPlane(_arKitController, anchor);
    }
  }

  void addPlane(
      ARKitController? kitController, ARKitPlaneAnchor kitPlaneAnchor) {
    anchorId = kitPlaneAnchor.identifier;

    if (node != null) {
      kitController?.remove(node!.name);
    }

    node = ARKitReferenceNode(
      url: 'models.scnassets/dash.dae',
      scale: vector.Vector3.all(0.3),
    );

    kitController?.add(
      node!,
      parentNodeName: kitPlaneAnchor.nodeName,
    );
  }
}
