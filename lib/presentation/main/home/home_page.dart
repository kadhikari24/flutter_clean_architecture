import 'package:carousel_slider/carousel_slider.dart';
import 'package:complete_advanced_flutter/app/dependencyInjector.dart';
import 'package:complete_advanced_flutter/domain/model/home.dart';
import 'package:complete_advanced_flutter/presentation/common/state_renderer/state_render_impl.dart';
import 'package:complete_advanced_flutter/presentation/main/home/home_viewmodel.dart';
import 'package:complete_advanced_flutter/presentation/resources/color_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/routes_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/strings_manager.dart';
import 'package:complete_advanced_flutter/presentation/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:complete_advanced_flutter/domain/model/home.dart' as Home;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _homeViewModel = instance<HomeViewModel>();

  void bind() {
    _homeViewModel.start();
  }

  @override
  void initState() {
    bind();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: StreamBuilder<FlowState>(
            stream: _homeViewModel.outputState,
            builder: (context, snapShot) =>
                snapShot.data?.getScreenWidget(
                    context, _getContentWidgets(), () => _homeViewModel.start()) ??
                _getContentWidgets()),
      ),
    );
  }

  Widget _getContentWidgets() {
    return StreamBuilder(
        stream: _homeViewModel.outputHomeData,
        builder: (context, snapshot) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _getBanner(snapshot.data?.banners),
              _getSectionTitle(AppStrings.services),
              _getServicesWidget(snapshot.data?.services),
              _getSectionTitle(AppStrings.stores),
              _getStoresWidget(snapshot.data?.stores),
            ],
          );
          ;
        });
  }

  @override
  void dispose() {
    _homeViewModel.dispose();
    super.dispose();
  }

  Widget _getSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppPadding.p12,
          top: AppPadding.p12,
          right: AppPadding.p12,
          bottom: AppPadding.p4),
      child: Text(
        title,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }

  Widget _getServicesWidget(List<Service>? services) {
    if (services != null) {
      return Padding(
        padding: const EdgeInsets.only(left: AppPadding.p12, right: AppPadding.p12),
        child: Container(
          height: AppSize.s140,
          margin: const EdgeInsets.symmetric(vertical: AppMargin.m12),
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: services
                .map((service) => Card(
                      elevation: AppSize.s4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(
                              color: ColorManager.white, width: AppSize.s1_5)),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(AppSize.s12),
                            child: Image.network(
                              service.image,
                              fit: BoxFit.cover,
                              width: AppSize.s120,
                              height: AppSize.s100,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: AppPadding.p8),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                service.title,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )
                        ],
                      ),
                    ))
                .toList(),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  Widget _getStoresWidget(List<Store>? stores) {
    if (stores != null) {
      return Padding(
        padding: const EdgeInsets.only(
            left: AppPadding.p12, right: AppPadding.p12, top: AppPadding.p12),
        child: Flex(
          direction: Axis.vertical,
          children: [
            GridView.count(
              crossAxisSpacing: AppSize.s8,
              mainAxisSpacing: AppSize.s8,
              physics: ScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(stores.length, (index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.storeDetailRoute);
                  },
                  child: Card(
                    elevation: AppSize.s4,
                    child: Image.network(
                      stores[index].image,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      );
    } else {
      return Container();
    }
  }


  Widget _getBanner(List<Home.Banner>? banners) {
    if (banners != null) {
      return CarouselSlider(
          items: banners
              .map((banner) => SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSize.s1_5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(AppSize.s12),
                          side: BorderSide(color: ColorManager.white, width: AppSize.s1_5)),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(AppSize.s12),
                        child: Image.network(
                          banner.image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ))
              .toList(),
          options: CarouselOptions(
              height: AppSize.s190,
              autoPlay: true,
              enableInfiniteScroll: true,
              enlargeCenterPage: true));
    } else {
      return Container();
    }
  }
}
