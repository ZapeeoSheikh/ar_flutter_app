//
// import 'package:flutter/material.dart';
// import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:vector_math/vector_math_64.dart' as vector;
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter AR Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'Flutter AR Demo'),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   late ARKitController arkitController;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ARKitSceneView(
//         onARKitViewCreated: onARKitViewCreated,
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     arkitController?.dispose();
//     super.dispose();
//   }
//
//   void onARKitViewCreated(ARKitController arkitController) {
//     this.arkitController = arkitController;
//     this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
//     this.arkitController.addNode(
//       ARKitNode(
//         geometry: ARKitSphere(
//           radius: 0.1,
//         ),
//         position: vector.Vector3(0, 0, -0.5),
//       ),
//     );
//   }
//
//   Future<void> _handleAddAnchor(ARKitAnchor anchor) async {
//     if (anchor is ARKitPlaneAnchor) {
//       this.arkitController.addNode(
//         ARKitNode(
//           geometry: ARKitSphere(
//             radius: 0.1,
//           ),
//           position: vector.Vector3(anchor.transform.getColumn(3).x, anchor.transform.getColumn(3).y, anchor.transform.getColumn(3).z),
//         ),
//       );
//     }
//   }
// }


import 'package:flutter/material.dart';
import 'package:arkit_plugin/arkit_plugin.dart';
// import 'package:vector_math/vector_math_64.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter AR Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter AR Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late ARKitController arkitController;
  List<ARKitNode> productList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ARKitSceneView(
              onARKitViewCreated: onARKitViewCreated,
            ),
          ),
          SizedBox(height: 10.0),
          Expanded(
            child: ListView.builder(
              itemCount: productList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('Product ${index + 1}'),
                  onTap: () => _selectProduct(productList[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    arkitController?.dispose();
    super.dispose();
  }

  void onARKitViewCreated(ARKitController arkitController) {
    this.arkitController = arkitController;
    this.arkitController.onAddNodeForAnchor = _handleAddAnchor;
    this.arkitController.add(
      ARKitNode(
        geometry: ARKitSphere(
          radius: 0.1,
        ),
        position: vector.Vector3(0, 0, -0.5),
      ),
    );
  }

  Future<void> _handleAddAnchor(ARKitAnchor anchor) async {
    if (anchor is ARKitPlaneAnchor) {
      productList.add(
        ARKitNode(
          geometry: ARKitSphere(
            radius: 0.1,
          ),
          position: vector.Vector3(anchor.transform.getColumn(3).x, anchor.transform.getColumn(3).y, anchor.transform.getColumn(3).z),
        ),
      );
      this.arkitController.add(productList.last);
    }
  }

  Future<void> _selectProduct(ARKitNode product) async {
    // show product information
  }
}