// import 'package:flutter/material.dart';
// import 'package:ride_sharing/config/app_config.dart' as config;
// import 'package:ride_sharing/view/main_screen_viewmodel.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({Key? key}) : super(key: key);

//   void _showModalSheet(BuildContext context, MainScreenViewModel model) {
//     showModalBottomSheet<dynamic>(
//       context: context,
//       isScrollControlled: true,
//       builder: (builder) {
//         return WillPopScope(
//           onWillPop: () async => false,
//           child: Container(
//             height: config.getProportionateScreenHeight(500),
//             child: rideComplete(context, model),
//           ),
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     // return BaseView<HomeScreenViewModel>(
//     //     onModelReady: (model) => model.init(),
//     //     builder: (context, model, child) {
//     return Scaffold(
//       body: Center(
//         child: Container(
//           height: 500,
//           decoration: const BoxDecoration(
//             gradient: LinearGradient(
//                 colors: [
//                   Color(0xFF3366FF),
//                   Color(0xFF00CCFF),
//                 ],
//                 begin: FractionalOffset(0.0, 0.0),
//                 end: FractionalOffset(1.0, 0.0),
//                 stops: [0.0, 1.0],
//                 tileMode: TileMode.clamp),
//           ),
//           child: Center(
//             child: Text(
//               'This is just a test Screen delete after use/to avoid model testing on home screen',
//               style: Theme.of(context).textTheme.headline3!.copyWith(
//                     color: Colors.white,
//                   ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           // _showModalSheet(context, model);
//           //Navigator.pushNamed(context, '/detail');
//         },
//         child: const Icon(Icons.add),
//       ),
//     );
//     // });
//   }
// }
