class OnBoardingModel {
  String? title;
  String? description;
  String? image;
  OnBoardingModel({this.title, this.description, this.image});
  static getOnBoard() {
    return [
      OnBoardingModel(
        title: 'Mange Your Tasks',
        image: 'assets/svg/on_board_1.svg',
        description: '',
      ),
      OnBoardingModel(
        title: 'Do All The Tasks',
        image: 'assets/svg/on_board_2.svg',
        description: '',
      ),
      OnBoardingModel(
        title: 'Complete Your Tasks',
        image: 'assets/svg/on_board_3.svg',
        description: '',
      ),
    ];
  }
}
