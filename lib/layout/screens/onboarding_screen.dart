import 'package:flutter/material.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/page_view.dart';
import 'package:habbit/layout/widgets/skip_button.dart';
import 'package:habbit/models/onboarding_model.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_screen.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({super.key});
  final List models = OnBoardingModel.getOnBoard();

  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(
        builder: ((context, state) {
          AppCubit cubit = context.read<AppCubit>();
          return Scaffold(
            backgroundColor: Colors.blue,
            appBar: AppBar(
              toolbarHeight: 40,
              actionsIconTheme: const IconThemeData(
                size: 50,
              ),
              elevation: 0,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 10),
                  child: Skipbutton(),
                )
              ],
            ),
            body: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 0.785,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(45),
                        bottomRight: Radius.circular(45),
                      )),
                  child: PageView.builder(
                    itemBuilder: (context, index) =>
                        PageViewBuilder(onBoardingModel: models[index]),
                    controller: controller,
                    onPageChanged: (value) {
                      cubit.changePage(value);
                    },
                    itemCount: models.length,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          controller.previousPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.bounceInOut);
                        },
                        child: const Text(
                          "BACK",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        effect: ScaleEffect(
                          activeDotColor: Colors.white,
                          dotColor: Colors.blueAccent.shade100,
                          dotHeight: 8.5,
                          dotWidth: 8.5,
                        ),
                        controller: controller,
                        count: models.length,
                      ),
                      TextButton(
                        onPressed: () {
                          if (cubit.currentIndex == models.length - 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => HomeScreen(),
                              ),
                            );
                          } else {
                            controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.bounceInOut);
                          }
                        },
                        child: Text(
                          cubit.currentIndex != models.length - 1
                              ? "NEXT"
                              : "FINISH",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
