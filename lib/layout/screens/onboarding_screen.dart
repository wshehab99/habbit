import 'package:flutter/material.dart';
import 'package:habbit/layout/widgets/page_view.dart';
import 'package:habbit/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final List models = OnBoardingModel.getOnBoard();
  int currentIndex = 0;
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [TextButton(onPressed: () {}, child: Text("Skip"))],
      ),
      body: Stack(
        children: [
          PageView.builder(
            itemBuilder: (context, index) =>
                PageViewBuilder(onBoardingModel: models[index]),
            controller: controller,
            onPageChanged: (value) {},
            itemCount: models.length,
            physics: const BouncingScrollPhysics(),
          ),
          Positioned(
            bottom: 25,
            right: MediaQuery.of(context).size.width * 0.41,
            child: SmoothPageIndicator(
              effect: const ScaleEffect(
                activeDotColor: Colors.orange,
                dotColor: Colors.blue,
                dotHeight: 8.5,
                dotWidth: 8.5,
              ),
              controller: controller,
              count: models.length,
            ),
          ),
        ],
      ),
    );
  }
}
