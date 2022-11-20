import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:habbit/cubit/app_cubit.dart';
import 'package:habbit/cubit/app_states.dart';
import 'package:habbit/layout/widgets/task_search_text_field.dart';
import 'package:habbit/layout/widgets/task_tail.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocBuilder<AppCubit, AppState>(builder: (context, state) {
        AppCubit cubit = context.read<AppCubit>();
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
                        searchMethod: (value) {
                          cubit.searchTask(search: value);
                        },
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
              ? SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LottieBuilder.asset("assets/img/search.json"),
                      Text("Search Tasks here"),
                    ],
                  ),
                )
              : cubit.searchedTasks.isEmpty
                  ? Center(
                      child: Text("There is no tasks with that name"),
                    )
                  : ListView.separated(
                      itemBuilder: (context, index) {
                        return TaskTail(
                          taskModel: cubit.searchedTasks[index],
                        );
                      },
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 15),
                      itemCount: cubit.searchedTasks.length,
                    ),
        );
      }),
    );
  }
}
