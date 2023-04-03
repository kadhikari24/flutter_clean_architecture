import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/font_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/styles_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lottie/lottie.dart';

enum StateRendererType {
  //popup states
  popupLoading,
  popupErrorState,

  // full screen states
  fullScreenLoadingState,
  fullScreenErrorState,
  contentScreenState, // ui of the screen
  emptyScreenState, // empty view when we receive data from api side for list screen
}

class StateRenderer extends StatelessWidget {
  final StateRendererType stateRendererType;
  final String message;
  final String title;
  final Function? retryActionFunction;

  const StateRenderer(
      {super.key,
      required this.stateRendererType,
      Failure? failure,
      this.message = AppStrings.loading,
      this.title = empty,
      required this.retryActionFunction});

  @override
  Widget build(BuildContext context) {
    return _getStateWidget(context);
  }

  Widget _getStateWidget(BuildContext context) {
    switch (stateRendererType) {
      case StateRendererType.popupLoading:
        return _getPopupDialog(context,[_getAnimatedImage(JsonAssets.loading)]);
      case StateRendererType.popupErrorState:
        return _getPopupDialog(context, [
          _getAnimatedImage(JsonAssets.errorJson),
          _getMessage(message),
          _getRetryButton(AppStrings.btnOK, retryActionFunction, context)
        ]);
      case StateRendererType.fullScreenLoadingState:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.loading), _getMessage(message)]);
      case StateRendererType.fullScreenErrorState:
        return _getItemsInColumn([
          _getAnimatedImage(JsonAssets.errorJson),
          _getMessage(message),
          _getRetryButton(AppStrings.btnRetry, retryActionFunction, context)
        ]);
      case StateRendererType.contentScreenState:
        return Container();
      case StateRendererType.emptyScreenState:
        return _getItemsInColumn([_getAnimatedImage(JsonAssets.emptyJson), _getMessage(message)]);
      default:
        return Container();
    }
  }

  Widget _getAnimatedImage(String jsonImage) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: SizedBox(
          height: AppSize.s100,
          width: AppSize.s100,
          child: Lottie.asset(jsonImage) // json image,
          ),
    );
  }

  Widget _getRetryButton(
      String buttonType, Function? action, BuildContext context) {
    return SizedBox(
      width: AppSize.s150,
      child: ElevatedButton(
          onPressed: () {
            if (stateRendererType == StateRendererType.fullScreenErrorState) {
              retryActionFunction?.call();
            } else {
              Navigator.of(context).pop();
            }
          },
          child: Text(buttonType)),
    );
  }

  Widget _getMessage(String message) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Text(message,
          textAlign: TextAlign.center,
          style: getMediumStyle(
              color: ColorManager.black, fontSize: FontSize.s16)),
    );
  }

  Widget _getItemsInColumn(List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: children,
        ),
      ),
    );
  }

  Widget _getPopupDialog(BuildContext context, List<Widget> children) {
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.s14)),
      elevation: AppSize.s1_5,
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: ColorManager.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(AppSize.s14),
            boxShadow: const [
              BoxShadow(
                  color: Colors.black26,
                  blurRadius: AppSize.s10,
                  offset: Offset(AppSize.s0, AppSize.s10))
            ]),
        child: _getDialogContent(context, children),
      ),
    );
  }

  Widget _getDialogContent(BuildContext context, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: children,
      ),
    );
  }
}
