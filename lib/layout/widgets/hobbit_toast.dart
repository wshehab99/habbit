import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HobbitToast {
  static Color _selectColor({required ToastState state}) {
    switch (state) {
      case ToastState.delete:
        return Colors.red.shade100.withOpacity(0.7);
      case ToastState.add:
        return Colors.blue.shade100.withOpacity(0.7);

      case ToastState.update:
        return Colors.green.shade100.withOpacity(0.7);
      case ToastState.error:
        return Colors.red.shade100.withOpacity(0.7);
    }
  }

  static String _selectMsg({required ToastState state}) {
    switch (state) {
      case ToastState.delete:
        return "Successfully deleted task!";
      case ToastState.add:
        return "Successfully added task!";
      case ToastState.update:
        return "Successfully updated task!";
      case ToastState.error:
        return "Please enter all the values";
    }
  }

  static showToast({required ToastState state}) {
    Fluttertoast.showToast(
      msg: _selectMsg(state: state),
      gravity:
          state == ToastState.error ? ToastGravity.CENTER : ToastGravity.BOTTOM,
      backgroundColor: _selectColor(state: state),
      textColor: Colors.black,
    );
  }
}

enum ToastState {
  delete,
  add,
  update,
  error,
}
