import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../utils/constants/images_url.dart';
import '../../../utils/constants/values_constant.dart';

class PhoneFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const PhoneFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 244, 244, 244),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        textDirection: TextDirection.rtl,
        children: [
          // العلم والسهم
          const SizedBox(width: 10),
          Container(
            width: 28,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              image: DecorationImage(
                image: AssetImage(ImagesUrl.imageIraq),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // TextField
          AutoWidthPhoneInput(controller: controller),

          const SizedBox(width: 5),

          // كود الدولة
          const Text(
            '+964',
            textDirection: TextDirection.ltr,
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class AutoWidthPhoneInput extends StatefulWidget {
  final TextEditingController controller;

  const AutoWidthPhoneInput({super.key, required this.controller});

  @override
  State<AutoWidthPhoneInput> createState() => _AutoWidthPhoneInputState();
}

class _AutoWidthPhoneInputState extends State<AutoWidthPhoneInput> {
  double inputWidth = 40;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateWidth);
    _updateWidth(); // لحساب العرض الابتدائي
  }

  void _updateWidth() {
    final text = widget.controller.text;
    final span = TextSpan(
      text: text.isEmpty ? 'اكتب رقمك هنا' : text,
      style: const TextStyle(fontSize: 16),
    );

    final tp = TextPainter(
      text: span,
      textDirection: TextDirection.ltr,
      maxLines: 1,
    )..layout();

    setState(() {
      inputWidth = tp.width + 20; // إضافة هامش بسيط
    });
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateWidth);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: inputWidth.clamp(80.0, 250.0),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: TextFormField(
          controller: widget.controller,
          keyboardType: TextInputType.phone,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(10),
          ],
          style: const TextStyle(fontSize: 16, color: Colors.black),
          decoration: const InputDecoration(
            isDense: true,
            border: InputBorder.none,
            hintText: 'اكتب رقمك هنا',
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
