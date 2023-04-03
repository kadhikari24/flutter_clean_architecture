import 'dart:async';

import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/extension/widget_extension.dart';
import 'package:complete_advanced_flutter/presentation/login/login_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _viewModel = instance<LoginViewModel>();
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _appPreference = instance<AppPreferences>();
  late StreamSubscription _subscribeLogin;


  bind() {
    _viewModel.start();
    _userNameController
        .addListener(() => _viewModel.setUserName(_userNameController.text));
    _passwordController
        .addListener(() => _viewModel.setPassword(_passwordController.text));
    _subscribeLogin = _viewModel.isUserLoggedInSuccessfully.stream.listen((isSuccessLoggedIn) {

      // navigate to main screen
     // Navigator.of(context).pushReplacementNamed(Routes.mainRoute); // we shouldn't directly called in as it is inside the stream
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _appPreference.setUserLoggedIn(true);
        Navigator.of(context).pushReplacementNamed(Routes.mainRoute);
      });
    });
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapShot) =>
              snapShot.data?.getScreenWidget(
                  context, _loginContent(), () => _viewModel.login()) ??
              _loginContent()),
    );
  }

  Widget _loginContent() {
    final theme = Theme.of(context).textTheme;
    return Center(
      child: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: AppSize.s40),
            Image.asset(ImageAssets.splashLogo),
            const SizedBox(height: AppSize.s40),
            StreamBuilder(
                stream: _viewModel.outputIsUserNameValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _userNameController,
                    decoration: InputDecoration(
                        hintText: AppStrings.usernameHint,
                        labelText: AppStrings.usernameHint,
                        errorText: snapshot.data ?? true
                            ? null
                            : AppStrings.invalidEmail),
                  );
                }),
            const SizedBox(height: AppSize.s10),
            StreamBuilder(
                stream: _viewModel.outputIsPasswordValid,
                builder: (context, snapshot) {
                  return TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: InputDecoration(
                        hintText: AppStrings.passwordHint,
                        labelText: AppStrings.passwordHint,
                        errorText: snapshot.data ?? true
                            ? null
                            : AppStrings.invalidPassword),
                  );
                }),
            const SizedBox(height: AppSize.s20),
            StreamBuilder<bool?>(
                stream: _viewModel.outputIsisAllInputsValid,
                builder: (context, snapShot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: ElevatedButton(
                        onPressed: !(snapShot.data ?? false)
                            ? null
                            : () => _viewModel.login(),
                        child: const Text(AppStrings.btnLogin)),
                  );
                }),
            const SizedBox(height: AppSize.s10),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.forgotPasswordRoute);
                },
                child: Text(
                  AppStrings.forgetPassword,
                  style: theme.titleSmall,
                )),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacementNamed(Routes.registerRoute);
                },
                child: Text(
                  AppStrings.notAMemberSignUp,
                  style: theme.titleSmall,
                  maxLines: 2,
                ))
          ],
        ).addPadding(right: 20, left: 20, top: 20, bottom: 20),
      )),
    );
  }

  @override
  void dispose() {
    _subscribeLogin.cancel();
    _viewModel.dispose();
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
