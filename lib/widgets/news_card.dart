//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class BackgroundImageScreen extends StatelessWidget {
//   const BackgroundImageScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double width = MediaQuery.of(context).size.width;
//     double height = MediaQuery.of(context).size.height;
//     String imageUrl =
//         "https://picsum.photos/" + width.toString() + "/" + (height*7/10).toInt().toString();
//     return AnnotatedRegion(
//       value: SystemUiOverlayStyle(
//         statusBarColor: Colors.transparent,
//
//       ),
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Image.network(
//               imageUrl,
//             ),
//             Positioned(child: Text("welcome flutter " ,style: TextStyle(
//                 fontSize: 39
//             ),))
//           ],
//         ),
//       ),
//     );
//   }
// }
