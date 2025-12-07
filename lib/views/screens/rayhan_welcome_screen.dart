// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../routes/app_routes.dart';

// class RayhanWelcomeScreen extends StatefulWidget {
//   const RayhanWelcomeScreen({super.key});

//   @override
//   State<RayhanWelcomeScreen> createState() => _RayhanWelcomeScreenState();
// }

// class _RayhanWelcomeScreenState extends State<RayhanWelcomeScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fade;
//   late Animation<Offset> _slide;

//   @override
//   void initState() {
//     super.initState();

//     // إعداد الانيميشن
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 900),
//     );

//     // شفافية
//     _fade = Tween<double>(
//       begin: 0,
//       end: 1,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     // الحركة من الأسفل للأعلى
//     _slide = Tween<Offset>(
//       begin: const Offset(0, 0.2),
//       end: Offset.zero,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     // تشغيل الأنيميشن
//     _controller.forward();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Directionality(
//       textDirection: TextDirection.rtl,
//       child: Scaffold(
//         body: Stack(
//           children: [
//             // الخلفية
//             Container(
//               decoration: const BoxDecoration(
//                 image: DecorationImage(
//                   image: AssetImage('assets/images/taxi_bg.jpg'),
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),

//             // تدرّج أسود
//             Container(
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0),
//                     Colors.black.withOpacity(0.85),
//                   ],
//                 ),
//               ),
//             ),

//             // المحتوى المتحرك
//             SafeArea(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: 24,
//                   vertical: 16,
//                 ),
//                 child: FadeTransition(
//                   opacity: _fade,
//                   child: SlideTransition(
//                     position: _slide,
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         const SizedBox(height: 16),
//                         const Spacer(),

//                         // العنوان
//                         RichText(
//                           text: TextSpan(
//                             children: [
//                               const TextSpan(
//                                 text: 'مرحباً بك\n',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               const TextSpan(
//                                 text: 'في تطبيق ',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.white,
//                                 ),
//                               ),
//                               TextSpan(
//                                 text: 'ريحان',
//                                 style: TextStyle(
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                   color: Colors.greenAccent,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const SizedBox(height: 16),

//                         // الوصف
//                         const Text(
//                           'ستجد ضمن تطبيقنا جميع الخدمات التي تسهل عليك تحقيق مهامك اليومية بأفضل شكل',
//                           style: TextStyle(
//                             fontSize: 16,
//                             height: 1.6,
//                             color: Colors.white70,
//                           ),
//                         ),

//                         const SizedBox(height: 24),

//                         // تسجيل الدخول
//                         Center(
//                           child: GestureDetector(
//                             onTap: () => Get.toNamed(AppRoutes.login),
//                             child: RichText(
//                               text: TextSpan(
//                                 children: [
//                                   const TextSpan(
//                                     text: 'هل لديك حساب؟ ',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.white70,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: 'تسجيل الدخول',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.greenAccent,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 8),

//                         // إنشاء حساب
//                         Center(
//                           child: GestureDetector(
//                             onTap: () => Get.toNamed(AppRoutes.register),
//                             child: RichText(
//                               text: TextSpan(
//                                 children: [
//                                   const TextSpan(
//                                     text: 'لا تملك حساباً؟ ',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       color: Colors.white70,
//                                     ),
//                                   ),
//                                   TextSpan(
//                                     text: 'إنشاء حساب جديد',
//                                     style: TextStyle(
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.bold,
//                                       color: Colors.greenAccent,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                         ),

//                         const SizedBox(height: 24),

//                         // الشريط
//                         Center(
//                           child: Container(
//                             width: 120,
//                             height: 4,
//                             decoration: BoxDecoration(
//                               color: Colors.white24,
//                               borderRadius: BorderRadius.circular(999),
//                             ),
//                           ),
//                         ),
//                         const SizedBox(height: 12),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
