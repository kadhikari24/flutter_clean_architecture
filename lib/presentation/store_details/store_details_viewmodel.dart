import 'dart:async';
import 'package:complete_advanced_flutter/domain/model/store_details.dart';
import 'package:complete_advanced_flutter/domain/usecase/store_details_usecase.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class StoreDetailsViewModel extends BaseViewModel
    implements StoreDetailsViewModelInputs, StoreDetailsViewModelOutputs {
  final StoreDetailsUseCase _storeDetailsUseCase;
  final _storeDetailsController = BehaviorSubject<StoreDetailsObject>();

  StoreDetailsViewModel(this._storeDetailsUseCase);

  @override
  void start() {
    _getStoresDetails();
  }

  @override
  void dispose() {
    _storeDetailsController.close();
    super.dispose();
  }

  Future<void> _getStoresDetails() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: AppStrings.loading));

    (await _storeDetailsUseCase.execute(null)).fold((l) {
      inputState.add(ErrorState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: l.message));
    }, (storeDetails) {
      inputState.add(ContentState());
      storeDetailsInput.add(storeDetails);
    });
  }

  @override
  Sink get storeDetailsInput => _storeDetailsController.sink;

  @override
  Stream<StoreDetailsObject> get storeDetailsOutputs =>
      _storeDetailsController.stream.map((storeDetails) => storeDetails);
}

abstract class StoreDetailsViewModelInputs {
  Sink get storeDetailsInput;
}

abstract class StoreDetailsViewModelOutputs {
  Stream<StoreDetailsObject> get storeDetailsOutputs;
}
