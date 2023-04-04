import 'dart:async';

import 'package:complete_advanced_flutter/app/functions.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/data/network/failure.dart';
import 'package:complete_advanced_flutter/domain/model/forgot_password.dart';
import 'package:complete_advanced_flutter/domain/usecase/forgot_password_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';

class ForgotPasswordViewModel extends BaseViewModel
    implements ForgotPasswordViewModelInput, ForgotPasswordViewModelOutput {
  final _emailStringController = StreamController<String>.broadcast();
  final ForgotPasswordUseCase _forgotPasswordUseCase;

  String email = "";

  ForgotPasswordViewModel(this._forgotPasswordUseCase);

  @override
  void start() {}

  @override
  void dispose() {
    _emailStringController.close();
    super.dispose();
  }

  @override
  Sink get getEmailInput => _emailStringController.sink;

  @override
  Stream<bool> get isValidEmail =>
      _emailStringController.stream.map((email) => _isValidEmail(email));

  @override
  void resetPassword() async {
    removeFocus();
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoading,
        message: AppStrings.loading));
    (await _forgotPasswordUseCase.execute(email)).fold((Failure failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message));
    }, (ForgotPassword password) {
      inputState.add(SuccessState(password.support ?? empty));
    });
  }

  @override
  void setEmail(String email) {
    this.email = email;
    getEmailInput.add(email);
  }

  // private Function
  _isValidEmail(String email) {
    print("_isValidEmail is called with $email");
    return email.isNotEmpty;
  }
}

abstract class ForgotPasswordViewModelInput {
  void setEmail(String email);

  void resetPassword();

  // sink
  Sink get getEmailInput;
}

abstract class ForgotPasswordViewModelOutput {
  Stream<bool> get isValidEmail;
}
