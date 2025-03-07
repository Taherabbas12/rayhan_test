// import 'package:get/get.dart';
// import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
// // import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// import 'package:media_alkafel_v2/app/views/widgets/message_snak.dart';

// import '../../../../controllers/request_badge_controlller.dart';
// import '../../../../utils/constants/color_app.dart';

// class ImageController extends GetxController {
//   RequestBadgeControlller requestBadgeControlller =
//       Get.find<RequestBadgeControlller>();
//   var faceDetected = RxBool(false);

//   Future<void> pickImage(ImageSource source) async {
//     final picker = ImagePicker();
//     final pickedFile = await picker.pickImage(source: source);

//     if (pickedFile != null) {
//       // cropImage(File(pickedFile.path));
//       detectFaces(File(pickedFile.path));
//     }
//   }

//   // Future<void> cropImage(File imageFile) async {
//   //   final croppedFile = await ImageCropper().cropImage(
//   //     sourcePath: imageFile.path,
//   //     aspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
//   //     uiSettings: [
//   //       AndroidUiSettings(
//   //           toolbarTitle: 'قص الصورة',
//   //           toolbarColor: Colors.deepOrange,
//   //           toolbarWidgetColor: Colors.white,
//   //           initAspectRatio: CropAspectRatioPreset.original,
//   //           lockAspectRatio: false),
//   //       IOSUiSettings(
//   //         title: 'قص الصورة',
//   //       ),
//   //     ],
//   //   );

//   //   if (croppedFile != null) {
//   //     this.imageFile.value = File(croppedFile.path);
//   //     detectFaces(this.imageFile.value!);
//   //   }
//   // }
//   // Future<void> cropImage(File imageFile) async {
//   //   final cropKey = GlobalKey<ImgCropState>();

//   //   final crop = cropKey.currentState;
//   //   final croppedFile =
//   //       await crop!.cropCompleted(File(imageFile.path), pictureQuality: 900);
//   //   await Get.generalDialog(
//   //       pageBuilder: (context, animation, secondaryAnimation) => Dialog(
//   //           child: SizedBox(
//   //               child: Center(
//   //                   child: ImgCrop(
//   //                       key: cropKey,
//   //                       chipShape: ChipShape.circle,
//   //                       maximumScale: 1,
//   //                       image: FileImage(File(imageFile.path)))))));

//   //   this.imageFile.value = File(croppedFile.path);
//   //   detectFaces(this.imageFile.value!);
//   // }

//   Future<void> detectFaces(File imageFiles) async {
//     final inputImage = InputImage.fromFilePath(imageFiles.path);
//     final options = FaceDetectorOptions(
//         enableContours: true,
//         minFaceSize: 1,
//         enableLandmarks: true,
//         enableClassification: true,
//         performanceMode: FaceDetectorMode.accurate,
//         enableTracking: true);
//     final faceDetector = FaceDetector(options: options);

//     try {
//       final List<Face> faces = await faceDetector.processImage(inputImage);
//       if (faces.isNotEmpty) {
//         faceDetected.value = true;
//         requestBadgeControlller.imageFileUser.value = imageFiles;
//         MessageSnak.message('تم التعرف على وجه!', color: ColorApp.greenColor);
//       } else {
//         faceDetected.value = false;
//         requestBadgeControlller.imageFileUser.value = null;
//         MessageSnak.message('لم يتم التعرف على أي وجه قريب.',
//             color: ColorApp.textFourColor);
//       }
//     } catch (e) {
//       requestBadgeControlller.imageFileUser.value = null;
//       MessageSnak.message('حدث خطأ أثناء التعرف على الوجه: $e');
//     } finally {
//       faceDetector.close();
//     }
//   }
// }
