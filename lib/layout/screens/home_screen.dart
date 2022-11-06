import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:habbit/layout/widgets/task_search_text_field.dart';
import 'package:habbit/layout/widgets/task_type_card.dart';
import 'package:habbit/models/task_type_model.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final List<TaskTypeModel> taskType = TaskTypeModel.getTaskTypes();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 55,
        title: Row(
          children: [
            Text(
              "June 03 2022",
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(child: TaskSearchTextField())
          ],
        ),
        titleSpacing: 10,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "My Tasks",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "See all",
                    style: TextStyle(
                      color: Colors.pink[200],
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            StaggeredGrid.count(
              crossAxisCount: 6,
              crossAxisSpacing: 15,
              mainAxisSpacing: 15,
              children: taskType.map((element) {
                return StaggeredGridTile.count(
                  crossAxisCellCount: element.crossAxisCellCount!,
                  mainAxisCellCount: element.mainAxisCellCount!,
                  child: TaskTypeCardWidget(
                    taskTypeModel: element,
                  ),
                );
              }).toList(),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              "On Going",
              style: TextStyle(
                fontSize: 22,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}