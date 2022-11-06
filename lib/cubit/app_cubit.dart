import 'package:bloc/bloc.dart';
import 'package:habbit/cubit/app_states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(InitialAppState());
  int currentIndex = 0;
  void changePage(int index) {
    currentIndex = index;
    emit(ChangePage());
  }
}
