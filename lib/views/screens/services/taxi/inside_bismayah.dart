import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rayhan_test/utils/constants/style_app.dart';

import '../../../../utils/constants/color_app.dart';
import '../../../../utils/constants/values_constant.dart';

class InsideBismayah extends StatelessWidget {
  const InsideBismayah({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: Values.circle * 2.4),
            inputDropDown(
              hintText: 'اختر البلوك',
              labelText: 'البلوك',
              items: ['A', 'B', 'C', 'D', 'E'],
              onChanged: (value) {},
            ),
            SizedBox(width: Values.circle * 2),
            inputDropDown(
              hintText: 'اختر البناية',
              labelText: 'البناية',
              items: ['1', '2', '3', '4', '5'],
              onChanged: (value) {},
            ),
            SizedBox(width: Values.circle * 2.4),
          ],
        ),
      ],
    );
  }

  Widget inputDropDown({
    String? hintText,
    String? labelText,
    String? initialValue,
    List<String>? items,
    void Function(String?)? onChanged,
  }) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (labelText != null)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(labelText, style: StringStyle.headerStyle),
            ),

          SizedBox(height: Values.circle),
          Container(
            height: 60,

            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: ColorApp.borderColor.withAlpha(50),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: ColorApp.borderColor),
            ),
            child: DropdownButtonFormField<String>(
              icon: Icon(CupertinoIcons.chevron_down),
              style: StringStyle.headerStyle,
              borderRadius: BorderRadius.circular(Values.circle),
              decoration: InputDecoration(
                border: InputBorder.none,

                hintText: hintText ?? 'اختر خيارًا',
              ),
              items:
                  items!
                      .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
              value: initialValue,
              onChanged: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}
