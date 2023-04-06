import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/domain/model/slider_object.dart';
import 'package:complete_advanced_flutter/presentation/extension/widget_extension.dart';
import 'package:complete_advanced_flutter/presentation/onboarding/onboarding_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/assets_manager.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key}) : super(key: key);

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView> {
  final PageController _pageController = PageController(initialPage: 0);
  final OnBoardingViewModel _viewModel = OnBoardingViewModel();
  final _appPreference = instance<AppPreferences>();

  void _bind(){
    _appPreference.setOnBoardingScreen();
    _viewModel.start();
  }

  @override
  void initState() {
    _bind();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SliderViewObject>(builder: (context, snapshot) {
      return _getContentWidget(snapshot.data);
    },
    stream: _viewModel.outputSliderViewObject,
    );
  }

  Widget _getContentWidget(SliderViewObject? sliderViewObject){
    if(sliderViewObject == null) return Container();
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
        elevation: AppSize.s0,
        backgroundColor: ColorManager.white,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorManager.white,
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: PageView.builder(
        controller: _pageController,
        itemCount: sliderViewObject.numOfSlides,
        onPageChanged: _viewModel.onPageChanged,
        itemBuilder: (context, index) => OnBoardingPage(_viewModel.list[index]),
      ),
      bottomSheet: Container(
        color: ColorManager.white,
        height: AppSize.s100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                  onPressed: () => goToLogin(),
                  child: Text(
                    AppStrings.skip,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.titleSmall,
                  ).tr()),
            ),
            Container(color:ColorManager.primary, child: _getBottomSheetWidget(sliderViewObject))
          ],
        ),
      ),
    );
  }

  Widget _getBottomSheetWidget(SliderViewObject sliderViewObject) {

    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      GestureDetector(
        child: SizedBox(
          height: AppSize.s20,
          width: AppSize.s20,
          child: SvgPicture.asset(ImageAssets.leftArrowIcon),
        ),
          onTap: () => _pageController.animateToPage(_viewModel.goPrevious(),
              duration: DurationConstant.d300milliSecond,
              curve: Curves.bounceInOut)),
      Row(children: _getCircularIndicate(sliderViewObject.numOfSlides, sliderViewObject.currentIndex)),
      GestureDetector(
        child: SizedBox(
          height: AppSize.s20,
          width: AppSize.s20,
          child: SvgPicture.asset(ImageAssets.rightArrowIcon),
        ),
          onTap: () => _pageController.animateToPage(_viewModel.gotNext(),
              duration: DurationConstant.d300milliSecond,
              curve: Curves.bounceInOut))
    ]).addPadding(
        left: AppSize.s14,
        right: AppSize.s14,
        top: AppSize.s14,
        bottom: AppSize.s14);
  }

  List<Widget> _getCircularIndicate(int total, int current) {
    var widgets = <Widget>[];
    for (int index = 0; index < total; index++) {
      widgets.add(SvgPicture.asset(current == index
              ? ImageAssets.solidCircleIcon
              : ImageAssets.hollowCircleIcon)
          .addPadding(right: 5, left: 5));
    }
    return widgets;
  }

  void goToLogin(){
    Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}

class OnBoardingPage extends StatelessWidget {
  final SliderObject slider;

  const OnBoardingPage(this.slider, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(slider.title,
            textAlign: TextAlign.center, style: textTheme.titleLarge).tr(),
        const SizedBox(height: AppSize.s8),
        Text(
          slider.subTitle,
          textAlign: TextAlign.center,
          style: textTheme.titleMedium,
        ).tr(),
        Expanded(child: Center(child: SvgPicture.asset(slider.image)))
        // Image(image: AssetImage(slider.image))
      ],
    ).addPadding(right: AppSize.s20, left: AppSize.s20);
  }
}


