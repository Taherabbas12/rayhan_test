import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/constants/color_app.dart';
 
class TermsAndConditionsPage extends StatelessWidget {
  const TermsAndConditionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // مهم للعرض بالعربي
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          title: const Text(
            'الشروط والأحكام',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            onPressed: () => Get.back(),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'آخر تحديث: 7 ديسمبر 2025',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
                const SizedBox(height: 16),

                //======== الكارد الرئيسي للنص ========//
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey.shade50,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // الشريط الجانبي الملون
                        Container(
                          width: 4,
                          decoration: BoxDecoration(
                            color: ColorApp.primaryColor,
                            borderRadius: const BorderRadius.only(
                              topRight: Radius.circular(18),
                              bottomRight: Radius.circular(18),
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),

                        // النصوص (قابلة للتمرير)
                        Expanded(
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                _mainTitle('تطبيق ريحان'),
                                const SizedBox(height: 12),
                                _bodyText(
                                  'يرجى قراءة هذه الشروط والأحكام بعناية قبل استخدام تطبيق ريحان. '
                                  'إن استخدام التطبيق أو أي من خدماته يعني موافقتك الكاملة على الشروط والأحكام الموضحة أدناه.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('1. نبذة عن التطبيق'),
                                _bodyText(
                                  'تطبيق ريحان هو منصة رقمية تقدّم خدمات توصيل داخل جمهورية العراق تشمل:',
                                ),
                                _bullet('توصيل منتجات السوبر ماركت'),
                                _bullet('توصيل الطعام من المطاعم'),
                                _bullet('التوصيل من متاجر مختلفة'),
                                _bodyText(
                                  'يعمل التطبيق كوسيط تقني لتنظيم الطلبات وتوفير خدمة التوصيل للمستخدمين.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('2. شروط الاستخدام'),
                                _bullet(
                                  'يلتزم المستخدم بتقديم معلومات صحيحة ودقيقة عند استخدام التطبيق.',
                                ),
                                _bullet(
                                  'يتحمل المستخدم مسؤولية جميع الأنشطة التي تتم عبر حسابه.',
                                ),
                                _bullet(
                                  'يمنع استخدام التطبيق لأي غرض مخالف للقوانين أو الأنظمة المعتمدة داخل العراق.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle(
                                  '3. شرط العمر والمحتوى المخصص للبالغين',
                                ),
                                _bodyText(
                                  'التطبيق متاح للاستخدام من قبل جميع الأعمار.\n'
                                  'تحتوي بعض الأقسام داخل التطبيق على منتجات مخصّصة للبالغين فقط (18+) وتشمل:',
                                ),
                                _bullet('السكائر'),
                                _bullet('الفيب'),
                                _bullet('الشيشة والأراكيل'),
                                _bullet('المعسل ومشتقاته'),
                                _bodyText(
                                  'باستخدام هذه الأقسام، يقرّ المستخدم بأنه بلغ السن القانوني المسموح به داخل جمهورية العراق، '
                                  'ويتحمل كامل المسؤولية القانونية عن ذلك. '
                                  'يحق لإدارة التطبيق رفض أو إلغاء أي طلب في حال عدم استيفاء شرط العمر.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('4. الحسابات'),
                                _bullet(
                                  'يتحمل المستخدم مسؤولية الحفاظ على سرية بيانات حسابه.',
                                ),
                                _bullet(
                                  'يحق لإدارة التطبيق تعليق أو إيقاف الحساب في حال:\n'
                                  '  • إساءة الاستخدام\n'
                                  '  • تقديم معلومات غير صحيحة\n'
                                  '  • انتهاك هذه الشروط والأحكام',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('5. الطلبات والدفع'),
                                _bullet(
                                  'تخضع جميع الطلبات لتوفر المنتجات لدى المطاعم والمتاجر.',
                                ),
                                _bullet(
                                  'الأسعار المعروضة هي الأسعار المعتمدة وقت الطلب.',
                                ),
                                _bullet(
                                  'يلتزم المستخدم بإتمام الدفع حسب الوسائل المتاحة داخل التطبيق.',
                                ),
                                _bullet(
                                  'يحق للتطبيق إلغاء أو تعديل الطلب في حال وجود ظرف تشغيلي أو تقني.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('6. التوصيل'),
                                _bullet(
                                  'يتم التوصيل إلى العنوان الذي يحدده المستخدم داخل التطبيق.',
                                ),
                                _bullet(
                                  'تقع مسؤولية دقة العنوان على المستخدم.',
                                ),
                                _bullet(
                                  'قد تختلف أوقات التوصيل حسب الموقع وحالة الطلب والظروف التشغيلية.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('7. سياسة الإلغاء والرفض'),
                                _bullet(
                                  'يحق للمستخدم إلغاء الطلب وفق السياسات المعتمدة داخل التطبيق.',
                                ),
                                _bullet(
                                  'يحق لتطبيق ريحان رفض أو إلغاء أي طلب يحتوي على:\n'
                                  '  • إساءة استخدام\n'
                                  '  • مخالفات قانونية\n'
                                  '  • معلومات غير صحيحة',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('8. الاستخدام المسموح'),
                                _bullet(
                                  'يمنع على المستخدم إساءة التعامل مع مندوبي التوصيل أو المتاجر.',
                                ),
                                _bullet(
                                  'يمنع محاولة الاحتيال أو التلاعب بالخدمات.',
                                ),
                                _bullet(
                                  'يمنع استخدام التطبيق بأي طريقة تضر بالتطبيق أو مستخدميه.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('9. الملكية الفكرية'),
                                _bodyText(
                                  'جميع الحقوق المتعلقة باسم التطبيق، الشعارات، المحتوى، والتصميم '
                                  'مملوكة لتطبيق ريحان. يُمنع نسخ أو استخدام أي جزء دون إذن رسمي.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('10. التعديلات'),
                                _bodyText(
                                  'يحتفظ تطبيق ريحان بحقه في تعديل هذه الشروط والأحكام في أي وقت. '
                                  'يُعتبر استمرار استخدام التطبيق موافقة على أي تحديث.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('11. إنهاء الخدمة'),
                                _bodyText(
                                  'يجوز لإدارة التطبيق:\n'
                                  '• إيقاف أو تعليق أي خدمة\n'
                                  '• إنهاء حساب أي مستخدم عند مخالفة الشروط',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('12. القانون المعمول به'),
                                _bodyText(
                                  'تخضع هذه الشروط والأحكام وتُفسر وفق قوانين جمهورية العراق.',
                                ),

                                const SizedBox(height: 24),
                                _sectionTitle('13. التواصل'),
                                _bodyText(
                                  'للاستفسارات أو الدعم، يمكن التواصل عبر:\n'
                                  'البريد الإلكتروني: rayhan.ltc.iq@gmail.com',
                                ),

                                const SizedBox(height: 12),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 16),
                // شريط صغير في الأسفل مثل iOS (اختياري)
                Container(
                  width: 80,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }

  //====== Widgets مساعدة للتنسيق ======//

  static Widget _mainTitle(String text) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
    );
  }

  static Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
    );
  }

  static Widget _bodyText(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        text,
        textAlign: TextAlign.justify,
        style: const TextStyle(
          fontSize: 14,
          height: 1.6,
          color: Colors.black87,
        ),
      ),
    );
  }

  static Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                fontSize: 14,
                height: 1.6,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
