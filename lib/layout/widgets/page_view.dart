import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:habbit/models/onboarding_model.dart';

class PageViewBuilder extends StatelessWidget {
  const PageViewBuilder({super.key, required this.onBoardingModel});
  final OnBoardingModel? onBoardingModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          onBoardingModel!.image!,
          height: MediaQuery.of(context).size.height * 0.30,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(onBoardingModel!.title!)
      ],
    );
  }
}
