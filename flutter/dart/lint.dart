




// 린트는 특정 구문만 인식하는 경우가 있음)

import 'package:flutter/cupertino.dart';

class Wid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: () async {
            await Future.delayed(const Duration(seconds: 3));
            // if (!context.mounted) return;
            Navigator.of(context).pop();
          },
        );
      },
    );
  }



}