import 'dart:async';

import 'package:complete_advanced_flutter/domain/model/home.dart';
import 'package:complete_advanced_flutter/domain/usecase/home_use_case.dart';
import 'package:complete_advanced_flutter/presentation/base/base_view_model.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_renderer.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:rxdart/rxdart.dart';

class HomeViewModel extends BaseViewModel
    implements HomeViewModelInputs, HomeViewModelOutputs {
  final HomeUseCase _homeUseCase;
  final _homeDataStreamController = BehaviorSubject<HomeViewObject>();

  HomeViewModel(this._homeUseCase);

  @override
  void start() {
    _getHome();
  }

  @override
  void dispose() {
    _homeDataStreamController.close();
    super.dispose();
  }

  void _getHome() async {
    inputState.add(LoadingState(
        stateRendererType: StateRendererType.fullScreenLoadingState,
        message: AppStrings.loading));
    (await _homeUseCase.execute(null)).fold((failure) {
      inputState.add(LoadingState(
          stateRendererType: StateRendererType.fullScreenErrorState,
          message: failure.message));
    }, (homeObject) {
      inputState.add(ContentState());
      inputHomeData.add(HomeViewObject(homeObject.data.stores, homeObject.data.banners, homeObject.data.services));
    });
  }

  @override
  Sink get inputHomeData => _homeDataStreamController.sink;

  @override
  Stream<HomeViewObject> get outputHomeData =>
      _homeDataStreamController.stream.map((homeData) => homeData);
}

abstract class HomeViewModelInputs {
  Sink get inputHomeData;
}

abstract class HomeViewModelOutputs {
  Stream<HomeViewObject> get outputHomeData;
}

class HomeViewObject {
  final List<Store> stores;
  final List<Banner> banners;
  final List<Service> services;

  HomeViewObject(this.stores, this.banners, this.services);
}
