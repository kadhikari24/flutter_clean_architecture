import 'dart:async';

import 'package:complete_advanced_flutter/domain/model/authentication.dart';
import 'package:complete_advanced_flutter/domain/usecase/login_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import 'package:complete_advanced_flutter/presentation/common/login_object.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';

class LoginViewModel extends BaseViewModel
    implements LoginViewModelInput, LoginViewModelOutput {
  final _userNameStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _isAllInputsValidStreamController = StreamController<void>.broadcast();
  final isUserLoggedInSuccessfully = StreamController<bool>.broadcast();
  var loginObject = const LoginObject(email: "", password: "");

  final LoginUseCase? _loginUseCase;

  LoginViewModel(this._loginUseCase);

  @override
  void dispose() {
    _userNameStreamController.close();
    _passwordStreamController.close();
    _isAllInputsValidStreamController.close();
    isUserLoggedInSuccessfully.close();
  }

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  login() async {
    // show loading
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoading,
        message: AppStrings.loading));

    // call api and check the result
    (await _loginUseCase?.execute(
            LoginUseCaseInput(loginObject.email, loginObject.password)))
        ?.fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message));
    }, (Authentication authentication) {
      inputState.add(ContentState());
      isUserLoggedInSuccessfully.add(true);
    });
  }

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isPasswordValid(password));

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  setPassword(String password) {
    inputPassword.add(password);
    loginObject = loginObject.copyWith(password: password);
    inputIsAllInputValid.add(null);
  }

  @override
  setUserName(String name) {
    inputUserName.add(name);
    loginObject = loginObject.copyWith(email: name);
    inputIsAllInputValid.add(null);
  }

  // private Function
  _isPasswordValid(String password) {
    return password.isNotEmpty;
  }

  // private Function
  _isUserNameValid(String userName) {
    return userName.isNotEmpty;
  }

  @override
  Sink get inputIsAllInputValid => _isAllInputsValidStreamController.sink;

  @override
  Stream<bool> get outputIsisAllInputsValid =>
      _isAllInputsValidStreamController.stream.map((_) => _isAllInputsValid());

  bool _isAllInputsValid() {
    return _isPasswordValid(loginObject.password) &&
        _isUserNameValid(loginObject.email);
  }
}

abstract class LoginViewModelInput {
  setUserName(String name);

  setPassword(String name);

  login();

  //two sinks
  Sink get inputUserName;

  Sink get inputPassword;

  Sink get inputIsAllInputValid;
}

abstract class LoginViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<bool> get outputIsPasswordValid;

  Stream<bool> get outputIsisAllInputsValid;
}
