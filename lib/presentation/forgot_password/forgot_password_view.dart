import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/extension/widget_extension.dart';
import 'package:complete_advanced_flutter/presentation/forgot_password/forgot_password_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordView> createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
 final _viewModel = instance<ForgotPasswordViewModel>();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  bind() {
    _viewModel.start();
    _emailController.addListener(() => _viewModel.setEmail(_emailController.text));
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
                  context, _loginContent(), () => _viewModel.resetPassword()) ??
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
                stream: _viewModel.isValidEmail,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    controller: _emailController,
                    decoration: InputDecoration(
                        hintText: AppStrings.emailHint,
                        labelText: AppStrings.emailHint,
                        errorText: snapshot.data ?? true
                            ? null
                            : AppStrings.invalidEmail),
                  );
                }),
            const SizedBox(height: AppSize.s20),
            StreamBuilder<bool?>(
                stream: _viewModel.isValidEmail,
                builder: (context, snapShot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: ElevatedButton(
                        onPressed: !(snapShot.data ?? false)
                            ? null
                            : () => _viewModel.resetPassword(),
                        child: Text(AppStrings.btnResetPassword)),
                  );
                }),
            const SizedBox(height: AppSize.s10),
            TextButton(
                onPressed: () {
                Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
                },
                child: Text(
                  AppStrings.don_tReceiveEmailResent,
                  style: theme.titleSmall,
                )),
          ],
        ).addPadding(right: 20, left: 20, top: 20, bottom: 20),
      )),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    _emailController.dispose();
    super.dispose();
  }
}
