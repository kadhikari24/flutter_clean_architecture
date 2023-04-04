import 'dart:async';

import 'package:complete_advanced_flutter/app/functions.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/domain/model/authentication.dart';
import 'package:complete_advanced_flutter/domain/usecase/register_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import 'package:complete_advanced_flutter/presentation/common/register/register_object.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';

class RegisterViewModel extends BaseViewModel
    implements RegisterViewModelInput, RegisterViewModelOutput {
  final _emailStreamController = StreamController<String>.broadcast();
  final _phoneNumberStreamController = StreamController<String>.broadcast();
  final _profileStreamController = StreamController<String?>.broadcast();
  final _userNameStreamController = StreamController<String>.broadcast();
  final _countryCodeStreamController = StreamController<String>.broadcast();
  final _passwordStreamController = StreamController<String>.broadcast();
  final _allInputValidController = StreamController<void>.broadcast();
  final isUserLoggedInSuccessfully = StreamController<bool>.broadcast();

  RegisterObject _registerObject = const RegisterObject(
      profilePicture: '',
      phoneNumber: '',
      password: '',
      email: '',
      countryCode: '+91',
      userName: '');
  final RegisterUseCase _registerUseCase;

  RegisterViewModel(this._registerUseCase);

  @override
  void start() {
    inputState.add(ContentState());
  }

  @override
  void dispose() {
    super.dispose();
    _emailStreamController.close();
    _phoneNumberStreamController.close();
    _profileStreamController.close();
    _userNameStreamController.close();
    _countryCodeStreamController.close();
    _passwordStreamController.close();
    _allInputValidController.close();
    isUserLoggedInSuccessfully.close();
  }

  @override
  void register() async {
    removeFocus();
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.popupLoading,
        message: AppStrings.loading));

    // call api and check the result
    (await _registerUseCase.execute(RegisterUseCaseInput(
      email: _registerObject.email,
      password: _registerObject.password,
      profilePicture: "" ,//_registerObject.profilePicture,
      countryCode: _registerObject.countryCode,
      phoneNumber: _registerObject.phoneNumber,
      userName: _registerObject.userName,
    )))
        .fold((failure) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.popupErrorState,
          message: failure.message));
    }, (Authentication authentication) {
    // inputState.add(ContentState());
      isUserLoggedInSuccessfully.add(true);
    });
  }

  @override
  Sink get inputEmail => _emailStreamController.sink;

  @override
  Sink get inputMobileNumber => _phoneNumberStreamController.sink;

  @override
  Sink get inputPassword => _passwordStreamController.sink;

  @override
  Sink get inputProfile => _profileStreamController.sink;

  @override
  Sink get inputUserName => _userNameStreamController.sink;

  @override
  Stream<bool> get outputIsEmailValid =>
      _emailStreamController.stream.map((event) => isEmailValid(event));

  @override
  Stream<String?> get outputErrorEmail => outputIsEmailValid
      .map((isValidEmail) => isValidEmail ? null : "Invalid Email");

  @override
  Stream<bool> get outputIsMobileNumberValid =>
      _phoneNumberStreamController.stream
          .map((number) => _isValidPhoneNumber(number));

  @override
  Stream<String?> get outputErrorMobileNumber => outputIsMobileNumberValid
      .map((isValidNumber) => isValidNumber ? null : "Invalid Number");

  @override
  Stream<bool> get outputIsPasswordValid => _passwordStreamController.stream
      .map((password) => _isValidPassword(password));

  @override
  Stream<String?> get outputErrorPassword => outputIsPasswordValid
      .map((isValidPassword) => isValidPassword ? null : "Invalid Password");

  // @override
  // Stream<String?> get outputErrorProfile => outputIsProfileValid
  //     .map((isValidProfile) => isValidProfile ? null : "Invalid Password");

  @override
  Stream<String> get outputProfilePicture =>
      _profileStreamController.stream.map((profile) => profile ?? empty);

  @override
  Stream<bool> get outputIsUserNameValid => _userNameStreamController.stream
      .map((userName) => _isUserNameValid(userName));

  @override
  Stream<String?> get outputErrorUserName => outputIsUserNameValid
      .map((isUsernameValid) => isUsernameValid ? null : "Invalid username");

  // private methods

  bool _isUserNameValid(String userName) {
    return userName.length >= 8;
  }

  bool _isValidPhoneNumber(String number) {
    return number.length >= 10;
  }

  _isValidPassword(String password) {
    return password.length >= 6;
  }

  @override
  void setEmail(String email) {
    inputEmail.add(email);
    if (isEmailValid(email)) {
      _registerObject = _registerObject.copyWith(email: email);
    } else {
      _registerObject = _registerObject.copyWith(email: '');
    }
    _validate();
  }

  @override
  void setPassword(String password) {
     inputPassword.add(password);
    if (_isValidPassword(password)) {
      _registerObject = _registerObject.copyWith(password: password);
    } else {
      _registerObject = _registerObject.copyWith(password: '');
    }
    _validate();
  }

  @override
  void setPhoneNumber(String number) {
    inputMobileNumber.add(number);
    if (_isValidPhoneNumber(number)) {
      _registerObject = _registerObject.copyWith(phoneNumber: number);
    } else {
      _registerObject = _registerObject.copyWith(phoneNumber: '');
    }
    _validate();
  }

  @override
  void setProfile(String picture) {
     inputProfile.add(picture);
    if (picture.isNotEmpty) {
      _registerObject = _registerObject.copyWith(profilePicture: picture);
    } else {
      _registerObject = _registerObject.copyWith(profilePicture: "");
    }
    _validate();
  }

  @override
  void setUserName(String userName) {
    inputUserName.add(userName);
    if (_isUserNameValid(userName)) {
      _registerObject = _registerObject.copyWith(userName: userName);
    } else {
      _registerObject = _registerObject.copyWith(userName: '');
    }
    _validate();
  }

  @override
  void setCountryCode(String code) {
    if (code.isNotEmpty) {
      _registerObject = _registerObject.copyWith(countryCode: code);
    } else {
      _registerObject = _registerObject.copyWith(countryCode: '');
    }
    _validate();
  }

  @override
  Sink get inputAllInputValid => _allInputValidController.sink;

  @override
  Stream<bool?> get outputISAllInputValid =>
      _allInputValidController.stream.map((_) => _validateAllInputs());

  bool _validateAllInputs() {
    return _registerObject.profilePicture.isNotEmpty &&
        _registerObject.password.isNotEmpty &&
        _registerObject.email.isNotEmpty &&
        _registerObject.phoneNumber.isNotEmpty &&
        _registerObject.countryCode.isNotEmpty &&
        _registerObject.phoneNumber.isNotEmpty;
  }

  _validate() {
    inputAllInputValid.add(null);
  }
}

abstract class RegisterViewModelInput {
  void register();

  void setPassword(String password);

  void setEmail(String email);

  void setUserName(String userName);

  void setPhoneNumber(String number);

  void setProfile(String file);

  void setCountryCode(String code);

  Sink get inputUserName;

  Sink get inputMobileNumber;

  Sink get inputEmail;

  Sink get inputPassword;

  Sink get inputProfile;

  Sink get inputAllInputValid;
}

abstract class RegisterViewModelOutput {
  Stream<bool> get outputIsUserNameValid;

  Stream<String?> get outputErrorUserName;

  Stream<bool> get outputIsMobileNumberValid;

  Stream<String?> get outputErrorMobileNumber;

  Stream<bool> get outputIsEmailValid;

  Stream<String?> get outputErrorEmail;

  Stream<String?> get outputProfilePicture;

  //Stream<String?> get outputErrorProfile;

  Stream<bool> get outputIsPasswordValid;

  Stream<String?> get outputErrorPassword;

  Stream<bool?> get outputISAllInputValid;
}
