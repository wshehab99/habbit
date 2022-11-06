import 'package:flutter/material.dart';
import 'package:habbit/layout/widgets/task_search_text_field.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            90,
          ),
          child: Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios),
                ),
                Expanded(
                  child: TaskSearchTextField(
                    controller: controller,
                    isSearch: true,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
              ],
            ),
          )),
      body: controller.text.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  LottieBuilder.asset("assets/img/search.json"),
                  Text("Search Tasks here"),
                ],
              ),
            )
          : SizedBox(),
    );
  }
}
