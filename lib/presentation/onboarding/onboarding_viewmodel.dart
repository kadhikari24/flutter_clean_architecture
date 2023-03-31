import 'dart:async';

import 'package:complete_advanced_flutter/domain/model/slider_object.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';

class OnBoardingViewModel extends BaseViewModel
    with OnBoardingViewModelInputs, OnBoardingViewModelOutputs {
  final StreamController _streamController =
      StreamController<SliderViewObject>();
  late final List<SliderObject> list;

  int _currentPage = 0;

  @override
  void dispose() {
    _streamController.close();
  }

  @override
  void start() {
    list = _getSliderData();
    _postDataToView();
  }

  List<SliderObject> _getSliderData() => [
        SliderObject(AppStrings.onBoardingTitle1,
            AppStrings.onBoardingSubtitle1, ImageAssets.onBoardingLogo1),
        SliderObject(AppStrings.onBoardingTitle2,
            AppStrings.onBoardingSubtitle2, ImageAssets.onBoardingLogo2),
        SliderObject(AppStrings.onBoardingTitle3,
            AppStrings.onBoardingSubtitle3, ImageAssets.onBoardingLogo3),
        SliderObject(AppStrings.onBoardingTitle4,
            AppStrings.onBoardingSubtitle4, ImageAssets.onBoardingLogo4),
      ];

  @override
  int goPrevious() {
    int nextIndex = _currentPage--;
    if (nextIndex < 0) {
      _currentPage = list.length - 1;
    }
    return _currentPage;
  }

  @override
  int gotNext() {
    int nextIndex = _currentPage++;
    if (nextIndex > list.length-1) {
      _currentPage = 0;
    }
    return _currentPage;
  }

  @override
  void onPageChanged(int index) {
    _currentPage = index;
    _postDataToView();
  }

  @override
  Sink get inputSliderViewObject => _streamController.sink;

  @override
  Stream<SliderViewObject> get outputSliderViewObject =>
      _streamController.stream.map((sliderViewObject) => sliderViewObject);

  void _postDataToView() {
    inputSliderViewObject.add(SliderViewObject(list[_currentPage], list.length, _currentPage));
  }
}

abstract class OnBoardingViewModelInputs {
  void gotNext();

  void goPrevious();

  void onPageChanged(int index);

  // this is the way oot add data to the stream .. stream input
  Sink get inputSliderViewObject;
}

abstract class OnBoardingViewModelOutputs {
  // will implement later
  Stream<SliderViewObject> get outputSliderViewObject;
}

class SliderViewObject {
  SliderObject sliderObject;
  int numOfSlides;
  int currentIndex;

  SliderViewObject(this.sliderObject, this.numOfSlides, this.currentIndex);
}
