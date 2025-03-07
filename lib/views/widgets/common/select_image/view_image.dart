// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';

// import '../../../../utils/constants/color_app.dart';
// import '../../more_widgets.dart';
// import 'image_controller.dart';

// class ImagePickerView extends StatelessWidget {
//   final ImageController imageController = Get.find<ImageController>();

//   ImagePickerView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Obx(() {
//         return Stack(children: [
//           CircleAvatar(
//               backgroundColor: ColorApp.primaryColor,
//               maxRadius: 80,
//               child: ClipOval(
//                   child: imageController
//                               .requestBadgeControlller.imageFileUser.value ==
//                           null
//                       ? Icon(Icons.person, size: 100)
//                       : Image.file(
//                           imageController
//                               .requestBadgeControlller.imageFileUser.value!,
//                           width: 155,
//                           height: 155,
//                           fit: BoxFit.cover))),
//           Positioned(
//               bottom: 0,
//               right: 20, // لتحديد الزاوية العلوية اليمنى
//               child: GestureDetector(
//                 onTap: () {
//                   // هنا استدعاء دالة اختيار الصورة
//                   showImagePicker(onPressedCamera: () {
//                     imageController.pickImage(ImageSource.camera);
//                     Get.backLegacy();
//                   }, onPressedGallery: () {
//                     imageController.pickImage(ImageSource.gallery);
//                     Get.backLegacy();
//                   });
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Colors.black54, // لون خلفية شفافة للأيقونة
//                     shape: BoxShape.circle,
//                   ),
//                   child: Icon(Icons.camera_alt, color: Colors.white, size: 24),
//                 ),
//               ))
//         ]);
//       }),
//     );
//   }
// }
