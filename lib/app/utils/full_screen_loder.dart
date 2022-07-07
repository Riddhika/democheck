import 'package:flutter/material.dart';
import 'app_constant.dart';

class FullScreenLoader extends StatelessWidget {
  const FullScreenLoader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white.withOpacity(0.8),
      child: const Center(
        child: CircularProgressIndicator(
          color: AppConstant.colorPrimary,
        ),
      ),
    );
  }
}
