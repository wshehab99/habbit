import 'package:flutter/material.dart';
import 'package:habbit/layout/widgets/bottom_sheet_widget.dart';

class CustomDockedButton extends StatelessWidget {
  const CustomDockedButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 45,
      width: 45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(23),
          gradient: LinearGradient(colors: [
            Colors.pink.shade400,
            Colors.pink.shade100,
          ])),
      child: FloatingActionButton(
        backgroundColor: Colors.transparent,
        hoverColor: Colors.transparent,
        focusElevation: 0,
        highlightElevation: 0,
        disabledElevation: 0,
        hoverElevation: 0,
        onPressed: () {
          showModalBottomSheet(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                top: Radius.circular(25),
              )),
              context: context,
              builder: (context) => BottomSheetWidget(
                    add: true,
                  ));
        },
        elevation: 0,
        child: Icon(Icons.add),
      ),
    );
  }
}
