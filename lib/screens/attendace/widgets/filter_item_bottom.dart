
import 'package:flutter/material.dart';

import '../../../constants/app_color.dart';

class FilterItemBottom extends StatelessWidget {

bool isCheck;
Function(bool?)  onChanged;
String title;


FilterItemBottom({required this.isCheck,required this.onChanged,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Checkbox(
              activeColor: ColorApp.PrimaryColor,
              shape: CircleBorder(),
              value: isCheck,
              onChanged:onChanged),
        ),
        Flexible(
          child: Text(
            title,
            style:
            TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
          ),
        )
      ],
    );
  }
}
