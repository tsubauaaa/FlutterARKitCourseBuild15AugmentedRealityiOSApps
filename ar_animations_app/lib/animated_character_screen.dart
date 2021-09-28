import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vector;

class AnimatedCharacterScreen extends StatefulWidget {
  const AnimatedCharacterScreen({Key? key}) : super(key: key);

  @override
  _AnimatedCharacterScreenState createState() =>
      _AnimatedCharacterScreenState();
}

class _AnimatedCharacterScreenState extends State<AnimatedCharacterScreen> {
  ARKitController? _arKitController;
  ARKitReferenceNode? _arKitReferenceNode;
  String? anchorId;
  bool idle = true;

  @override
  void dispose() {
    super.dispose();
    _arKitController?.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(idle ? Icons.play_arrow : Icons.pause),
          onPressed: () async {
            if (_arKitReferenceNode != null) {
              if (idle) {
                await _arKitController?.playAnimation(
                  key: 'dancing',
                  sceneName: 'models.scnassets/twist_danceFixed',
                  animationIdentifier: 'twist_danceFixed-1',
                );
              } else {
                await _arKitController?.stopAnimation(key: 'dancing');
              }

              setState(
                () {
                  idle = !idle;
                },
              );
            }
          },
        ),
        body: Container(
          child: ARKitSceneView(
            showFeaturePoints: true,
            planeDetection: ARPlaneDetection.horizontal,
            onARKitViewCreated: createARKitView,
          ),
        ),
      );

  void createARKitView(ARKitController arKitController) {
    _arKitController = arKitController;
    _arKitController!.onAddNodeForAnchor = handleAddAnchor;
  }

  void handleAddAnchor(ARKitAnchor anchor) {
    if (anchor is! ARKitPlaneAnchor) {
      return;
    }
    // add plane here
    addPlane(_arKitController!, anchor);
  }

  void addPlane(ARKitController controller, ARKitPlaneAnchor planeAnchor) {
    anchorId = planeAnchor.identifier;
    if (_arKitReferenceNode != null) {
      controller.remove(_arKitReferenceNode!.name);
    }

    _arKitReferenceNode = ARKitReferenceNode(
      // add idle animated character - standing character
      url: 'models.scnassets/idleFixed.dae',
      position: vector.Vector3(0, 0, 0),
      scale: vector.Vector3(0.02, 0.02, 0.02),
    );

    controller.add(
      _arKitReferenceNode!,
      parentNodeName: planeAnchor.nodeName,
    );
  }
}
