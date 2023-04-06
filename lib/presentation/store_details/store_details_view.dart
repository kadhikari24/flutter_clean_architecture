import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/domain/model/store_details.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:complete_advanced_flutter/presentation/store_details/store_details_viewmodel.dart';
import 'package:flutter/material.dart';

class StoreDetailsView extends StatefulWidget {
  const StoreDetailsView({Key? key}) : super(key: key);

  @override
  State<StoreDetailsView> createState() => _StoreDetailsViewState();
}

class _StoreDetailsViewState extends State<StoreDetailsView> {
  final _viewModel = instance<StoreDetailsViewModel>();

  void bind() {
    _viewModel.start();
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppStrings.storeDetails),
      ),
      body: StreamBuilder<FlowState>(
          stream: _viewModel.outputState,
          builder: (context, snapShot) =>
              snapShot.data?.getScreenWidget(
                  context, _getContentWidgets(), () => _viewModel.start()) ??
              _getContentWidgets()),
    );
  }

  Widget _getContentWidgets() {
    return StreamBuilder(
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          final StoreDetailsObject data = snapshot.data!;
          return _getStoreDetails(data);
        } else {
          return const SizedBox();
        }
      },
      stream: _viewModel.storeDetailsOutputs,
    );
  }

  Widget _getStoreDetails(StoreDetailsObject data) {
    final titleStyle = Theme.of(context).textTheme.displayLarge;
    final contentStyle = Theme.of(context).textTheme.bodyLarge;
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(AppPadding.p8),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              width: double.infinity,
              constraints: BoxConstraints(maxHeight: AppSize.s400),
              child: Image.network(
                data.image,
                fit: BoxFit.cover,
              )),
          const SizedBox(height: AppSize.s14),
          Text(AppStrings.details, style: titleStyle),
          const SizedBox(height: AppSize.s8),
          Text(data.details, style: contentStyle),
          const SizedBox(height: AppSize.s14),
          Text(AppStrings.services, style: titleStyle),
          const SizedBox(height: AppSize.s8),
          Text(data.services, style: contentStyle),
          const SizedBox(height: AppSize.s14),
          Text(AppStrings.stores, style: titleStyle),
          const SizedBox(height: AppSize.s8),
          Text(data.about, style: contentStyle),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }
}
