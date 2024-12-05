// ignore_for_file: prefer_const_constructors, missing_required_param, lines_longer_than_80_chars, avoid_print, always_declare_return_types, public_member_api_docs

import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/provider/home_provider.dart';
import 'package:bb3_ecommerce_app/src/widget/widget.dart';
import 'package:bb3_ecommerce_app/utilities/asset/asset_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/route/route_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///Home screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      HomeProvider homeProvider = Provider.of<HomeProvider>(context, listen: false);
      homeProvider.callAllBrandApi(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<HomeProvider>(builder: (_, HomeProvider homeProvider, __) {
      return Scaffold(
        backgroundColor: VariableUtilities.theme.backgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 8.h),
              // APPBAR LOGO WIDGET
              Image(
                image: const AssetImage(AssetUtilities.logoPng),
                width: VariableUtilities.screenSize.width * 0.25,
              ),
              SizedBox(height: 15.h),
              // SEARCH_BAR UI
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, RouteUtilities.searchScreen);
                  },
                  child: Container(
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: VariableUtilities.theme.color444444.withOpacity(0.05)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      child: Row(
                        children: [
                          Icon(Icons.search, color: VariableUtilities.theme.color7C7C7C),
                          SizedBox(width: 6),
                          Text(
                            'Search',
                            style: FontUtilities.h11(fontColor: VariableUtilities.theme.color7C7C7C, fontWeight: FWT.medium),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 220.0,
                          viewportFraction: 1,
                          autoPlay: true,
                          autoPlayInterval: const Duration(seconds: 3),
                          onPageChanged: (index, reason) {
                            homeProvider.currentPage = index;
                          },
                        ),
                        items: homeProvider.carouselSliderImages.map(
                          (e) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Center(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width - 20,
                                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                    decoration: BoxDecoration(
                                        color: VariableUtilities.theme.blackColor,
                                        border: Border.all(color: VariableUtilities.theme.whiteColor),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))),
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                                      child: Image(
                                        image: AssetImage(e),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ).toList(),
                      ),
                      SizedBox(height: 6),
                      //  Shop By Brand Widget
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Shop By Brand',
                            style: FontUtilities.h12(fontWeight: FWT.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: homeProvider.allBrandModel.isLeft
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: homeProvider.allBrandModel.left.data!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Container(
                                          decoration: BoxDecoration(border: Border.all(color: VariableUtilities.theme.blackColor.withOpacity(0.10)), borderRadius: BorderRadius.circular(12)),
                                          child: Stack(
                                            alignment: Alignment.bottomRight,
                                            children: [
                                              CachedNetworkImage(
                                                imageUrl: '${AssetUtilities.liveImageUrlPrefix}${homeProvider.allBrandModel.left.data![index].image}',
                                                height: VariableUtilities.screenSize.height * 0.25,
                                                width: VariableUtilities.screenSize.width,
                                                fit: BoxFit.cover,
                                                placeholder: (_, __) {
                                                  return Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [Image.asset(AssetUtilities.logoPng, height: 100, width: 100)],
                                                  );
                                                },
                                                errorWidget: (_, __, ___) {
                                                  return const Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [Icon(Icons.error, color: Colors.black54)],
                                                  );
                                                },
                                              ),
                                              Container(
                                                height: VariableUtilities.screenSize.height * 0.25,
                                                width: VariableUtilities.screenSize.width,
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                  begin: Alignment.bottomCenter,
                                                  end: Alignment.topCenter,
                                                  colors: const [
                                                    Colors.black,
                                                    Colors.black45,
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                    Colors.transparent,
                                                  ],
                                                )),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                                                child: Text(
                                                  homeProvider.allBrandModel.left.data![index].title ?? 'Unknown Product',
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: FontUtilities.h12(fontWeight: FWT.black, fontColor: VariableUtilities.theme.whiteColor),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                    ],
                                  );
                                },
                              )
                            : ListView.builder(
                                itemCount: 5,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: AdsShimmerEffect(),
                                  );
                                },
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
