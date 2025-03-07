// // ignore_for_file: must_be_immutable

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';

// import '../../../controllers/auth_controller.dart';
// import '../../../utils/constants/color_app.dart';
// import '../../../utils/constants/images_url.dart';
// import '../../../utils/constants/style_app.dart';
// import '../../../utils/constants/values_constant.dart';
// import '../../../utils/validators.dart';
// import '../../widgets/actions_button.dart';
// import '../../widgets/common/loading_indicator.dart';
// import '../../widgets/input_text.dart';

// class Register extends StatelessWidget {
//   Register({super.key});
//   AuthController authController = Get.find<AuthController>();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: EdgeInsets.symmetric(horizontal: Values.spacerV.h),
//         child: ListView(
//           children: [
//             SizedBox(height: Values.spacerV * 3),
//             SvgPicture.asset(ImagesUrl.logoSVG),
//             SizedBox(height: Values.spacerV * 2),
//             Center(
//               child: Text(
//                 'تطبيق إعلامي هو تطبيق يسهل وصول\nالمصوورين والاعلاميين لأماكن خاصة لتغطيتها',
//                 textAlign: TextAlign.center,
//                 style: StringStyle.textLabil,
//               ),
//             ),
//             SizedBox(height: Values.spacerV * 2),
//             Form(
//               autovalidateMode: AutovalidateMode.always,
//               key: authController.formKeyRegister,
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   // Personal information
//                   InputText.inputStringValidatorIcon(
//                     'الأسم الكامل',
//                     authController.fullName,
//                     icon: CupertinoIcons.person,
//                     validator: (v) => Validators.notEmpty(v, 'الأسم'),
//                   ),
//                   SizedBox(height: Values.circle),
//                   InputText.inputStringValidatorIcon(
//                     'العنوان الوظيفي',
//                     authController.jobTitle,
//                     icon: Icons.work_outline,
//                     validator: (v) => Validators.notEmpty(v, 'العنوان الوظيفي'),
//                   ),
//                   SizedBox(height: Values.circle),
//                   InputText.inputStringValidatorIcon(
//                     'البريد الإلكتروني',
//                     authController.email,
//                     icon: Icons.alternate_email_outlined,
//                     validator: Validators.email,
//                   ),
//                   SizedBox(height: Values.circle),
//                   InputText.inputStringValidatorIcon(
//                     'رقم الموبايل',
//                     authController.phoneNumber,
//                     icon: CupertinoIcons.phone,
//                     validator: Validators.phone,
//                   ),
//                   SizedBox(height: Values.circle),
//                   // Select Contres
//                   DropdownContres(),
//                   SizedBox(height: Values.circle),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                     child: Divider(
//                       color: ColorApp.subColor.withAlpha(150),
//                       thickness: 0.8,
//                     ),
//                   ),
//                   // Password
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text('كلمة المرور', style: StringStyle.headerStyle),
//                   ),
//                   SizedBox(height: Values.circle),
//                   InputText.inputStringValidatorIcon(
//                     isPassword: true,
//                     'كلمة المرور ',
//                     authController.password,
//                     validator: Validators.password,
//                     icon: Icons.password_outlined,
//                   ),
//                   SizedBox(height: Values.spacerV),
//                   InputText.inputStringValidatorIcon(
//                     isPassword: true,
//                     'كلمة المرور ',
//                     authController.confirmPassword,
//                     validator:
//                         (v) => Validators.confirmPassword(
//                           v,
//                           authController.password.text,
//                         ),
//                     icon: Icons.password_outlined,
//                   ),
//                   SizedBox(height: Values.spacerV),
//                 ],
//               ),
//             ),

//             SizedBox(height: Values.spacerV),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: Values.spacerV),
//               child: Obx(
//                 () =>
//                     authController.isLoading.value
//                         ? LoadingIndicator()
//                         : BottonsC.action1(
//                           'حساب جديد',
//                           authController.submitFormRegister,
//                           icon: Icons.keyboard_arrow_left_outlined,
//                         ),
//               ),
//             ),
//             //
//             SizedBox(height: Values.spacerV),
//             Center(
//               child: RichText(
//                 text: TextSpan(
//                   text: 'لديك حساب ؟ ',
//                   style: StringStyle.textLabil,
//                   children: [
//                     TextSpan(
//                       text: 'سجل دخول',
//                       style: StringStyle.textLabil.copyWith(
//                         color: ColorApp.primaryColor,
//                       ),
//                       recognizer:
//                           TapGestureRecognizer()
//                             // هنا يمكنك تحديد ما يحدث عند النقر على النصx
//                             ..onTap = Get.back,
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             SizedBox(height: Values.spacerV),
//           ],
//         ),
//       ),
//     );
//   }
// }
