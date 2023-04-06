import 'dart:async';
import 'dart:io';

import 'package:complete_advanced_flutter/app/app_pref.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/data/mapper/mapper.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/extension/widget_extension.dart';
import 'package:complete_advanced_flutter/presentation/register/register_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/assets_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final _viewModel = instance<RegisterViewModel>();
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = instance<ImagePicker>();
  final _appPreference = instance<AppPreferences>();
  late StreamSubscription _subscribeLogin;

  @override
  void initState() {
    _subscribeLogin = _viewModel.isUserLoggedInSuccessfully.stream.listen((isSuccessLoggedIn) {

      // navigate to main screen
     // Navigator.of(context).pushReplacementNamed(Routes.mainRoute); // we shouldn't directly called in as it is inside the stream
      SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
        _appPreference.setUserLoggedIn(true);
        Navigator.of(context).pushNamedAndRemoveUntil(Routes.mainRoute, (route) => false);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.white,
      appBar: AppBar(
          backgroundColor: ColorManager.white,
          elevation: AppSize.s0,
          iconTheme: IconThemeData(color: ColorManager.primary)),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapShot) =>
              snapShot.data?.getScreenWidget(
                  context, _registerContent(), () => _viewModel.register()) ??
              _registerContent()),
    );
  }

  Widget _registerContent() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: AppSize.s10),
            Image.asset(ImageAssets.splashLogo),
            const SizedBox(height: AppSize.s20),
            StreamBuilder<String?>(
                stream: _viewModel.outputErrorUserName,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) => _viewModel.setUserName(value),
                    decoration: InputDecoration(
                        hintText: AppStrings.name,
                        labelText: AppStrings.name,
                        errorText: snapshot.data),
                  );
                }),
            const SizedBox(height: AppSize.s20),
            Center(
              child: Row(
                children: [
                  Expanded(
                      flex: 1,
                      child: CountryCodePicker(
                        onChanged: (country) {
                          _viewModel.setCountryCode(country.dialCode ?? empty);
                        },
                        initialSelection: "+91",
                        showOnlyCountryWhenClosed: true,
                        hideMainText: true,
                        showCountryOnly: true,
                        favorite: const ["+1", '+91', '+977'],
                      )),
                  Expanded(
                    flex: 3,
                    child: StreamBuilder<String?>(
                        stream: _viewModel.outputErrorMobileNumber,
                        builder: (context, snapshot) {
                          return TextFormField(
                            keyboardType: TextInputType.phone,
                            onChanged: (value) => _viewModel.setPhoneNumber(value),
                            decoration: InputDecoration(
                                hintText: AppStrings.number,
                                labelText: AppStrings.number,
                                errorText: snapshot.data),
                          );
                        }),
                  )
                ],
              ),
            ),
            const SizedBox(height: AppSize.s20),
            StreamBuilder<String?>(
                stream: _viewModel.outputErrorEmail,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => _viewModel.setEmail(value),
                    decoration: InputDecoration(
                        hintText: AppStrings.emailHint,
                        labelText: AppStrings.emailHint,
                        errorText: snapshot.data),
                  );
                }),
            const SizedBox(height: AppSize.s20),
            StreamBuilder<String?>(
                stream: _viewModel.outputErrorPassword,
                builder: (context, snapshot) {
                  return TextFormField(
                    keyboardType: TextInputType.name,
                    onChanged: (value) => _viewModel.setPassword(value),
                    decoration: InputDecoration(
                        hintText: AppStrings.passwordHint,
                        labelText: AppStrings.passwordHint,
                        errorText: snapshot.data),
                  );
                }),
            const SizedBox(height: AppSize.s20),
            SizedBox(
                width: double.infinity,
                height: AppSize.s50,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p8, vertical: AppPadding.p8),
                  decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.lightGrey),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(AppSize.s8))),
                  child: GestureDetector(
                    child: _mediaWidget(),
                    onTap: () {
                      if (Platform.isMacOS || Platform.isWindows || kIsWeb) {
                        _filePicker();
                      } else {
                        _showPicker(context);
                      }
                    },
                  ),
                )),
            const SizedBox(height: AppSize.s20),
            StreamBuilder<bool?>(
                stream: _viewModel.outputISAllInputValid,
                builder: (context, snapShot) {
                  return SizedBox(
                    width: double.infinity,
                    height: AppSize.s40,
                    child: ElevatedButton(
                        onPressed: !(snapShot.data ?? false)
                            ? null
                            : () => _viewModel.register(),
                        child: Text(AppStrings.btnRegister)),
                  );
                }),
            const SizedBox(height: AppSize.s20),
            TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: Text(
                  AppStrings.notAMemberSignUp,
                  style: Theme.of(context).textTheme.titleSmall,
                  maxLines: 2,
                ))
          ],
        ).addPadding(
          right: AppSize.s20,
          left: AppSize.s20,
          top: AppSize.s20,
          bottom: AppSize.s20,
        ),
      ),
    );
  }

  Widget _mediaWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Flexible(child: Text(AppStrings.profilePicture)),
      Flexible(
          child: StreamBuilder<String?>(
              stream: _viewModel.outputProfilePicture,
              builder: (context, snapShot) {
                return _imagePickedByUser(snapShot.data);
              })),
      Flexible(child: SvgPicture.asset(ImageAssets.cameraIcon))
    ]);
  }

  Widget _imagePickedByUser(String? data) {
    if (data != null && data.isNotEmpty) {
      return Image.file(File(data));
    } else {
      return Container();
    }
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return SafeArea(
            child: Wrap(
          children: [
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera),
              title: Text(AppStrings.photoGallery),
              onTap: () {
                _imageFormGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              trailing: const Icon(Icons.arrow_forward),
              leading: const Icon(Icons.camera_alt),
              title: Text(AppStrings.photoCamera),
              onTap: () {
                _imageFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ));
      },
    );
  }

  Future<void> _imageFormGallery() async {
    var image = await _imagePicker.pickImage(source: ImageSource.camera);
    _viewModel.setProfile(image?.path ?? empty);
  }

  Future<void> _imageFromCamera() async {
    var image = await _imagePicker.pickImage(source: ImageSource.gallery);
    _viewModel.setProfile(image?.path ?? empty);
  }

  Future<void> _filePicker() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);
    _viewModel.setProfile(result?.files.first.path ?? empty);
  }

  @override
  void dispose() {
    _subscribeLogin.cancel();
    _viewModel.dispose();
    super.dispose();
  }
}
