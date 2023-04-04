import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:flutter/material.dart';

abstract class FlowState {
  StateRendererType getStateRendererType();

  String getMessage();
}

// Loading state(POPUP , FULL SCREEN)

class LoadingState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  LoadingState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// error state (POPUP, FULL SCREEN)
class ErrorState extends FlowState {
  final StateRendererType stateRendererType;
  final String message;

  ErrorState({required this.stateRendererType, required this.message});

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => stateRendererType;
}

// content state

class ContentState extends FlowState {
  @override
  String getMessage() => empty;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.contentScreenState;
}

// content state

class SuccessState extends FlowState {
  final String message;

  SuccessState(this.message);
  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() => StateRendererType.popupSuccess;
}

// empty state

class EmptyState extends FlowState {
  String message;

  EmptyState(this.message);

  @override
  String getMessage() => message;

  @override
  StateRendererType getStateRendererType() =>
      StateRendererType.emptyScreenState;
}

extension FlowStateExtension on FlowState {
  Widget getScreenWidget(BuildContext context, Widget contentWidget,
      Function retryActionFunction) {
    switch (runtimeType) {
      case LoadingState:
        if (getStateRendererType() == StateRendererType.popupLoading) {
          _showPopup(context, getStateRendererType(), getMessage());
          return contentWidget;
        } else {
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction);
        }

      case ErrorState:
         _dismissDialog(context);
        if (getStateRendererType() == StateRendererType.popupErrorState) {
          _showPopup(context, getStateRendererType(), getMessage());
          return contentWidget;
        } else {
          return StateRenderer(
              message: getMessage(),
              stateRendererType: getStateRendererType(),
              retryActionFunction: retryActionFunction);
        }

      case ContentState:
        _dismissDialog(context);
        return contentWidget;

      case EmptyState:
        return StateRenderer(
            message: getMessage(),
            stateRendererType: getStateRendererType(),
            retryActionFunction: retryActionFunction);

      case SuccessState:
        _dismissDialog(context);
        _showPopup(context, getStateRendererType(), getMessage(),
            title: AppStrings.dialogSuccessTitle);
        return contentWidget;

      default:
        return contentWidget;
    }
  }

  _dismissDialog(BuildContext context){
    if (_isThereCurrentDialogShowing(context)) {
      Navigator.of(context, rootNavigator: true).pop(true);
    }
  }

  _isThereCurrentDialogShowing(BuildContext context) => ModalRoute.of(context)?.isCurrent != true;

  _showPopup(BuildContext context, StateRendererType type, String message,{String title = empty}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => StateRenderer(
                stateRendererType: type,
                message: message,
                title: title,
                retryActionFunction: () {},
              ));
    });
  }
}
