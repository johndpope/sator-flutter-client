import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:satorio/model/onboarding_data.dart';

class OnBoardingController extends GetxController {
  final PageController pageController = PageController();
  final RxBool isLastPage = false.obs;

  List<OnBoardingData> data = [
    OnBoardingData(
      'Onboarding 1',
      'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
      'images/on_boarding.svg',
    ),
    OnBoardingData(
      'Onboarding 2',
      'Maecenas lacinia efficitur dictum. Pellentesque eu nulla sit amet mi semper vestibulum vel et ligula.',
      'images/on_boarding.svg',
    ),
    OnBoardingData(
      'Onboarding 3',
      'Curabitur posuere, dolor quis commodo vulputate, odio nunc maximus ex, sed faucibus elit ex',
      'images/on_boarding.svg',
    ),
  ];

  @override
  void onInit() {
    pageController.addListener(_listener);
  }

  @override
  void onClose() {
    pageController.removeListener(_listener);
    pageController.dispose();
  }

  _listener() {
    final page = pageController.page.round();
    isLastPage.value = page == data.length - 1;
  }

  void nextOrJoin() {
    if (isLastPage.value) {
      // TODO: move to Login Page
    } else {
      pageController.nextPage(
        duration: Duration(milliseconds: 250),
        curve: Curves.easeIn,
      );
    }
  }
}