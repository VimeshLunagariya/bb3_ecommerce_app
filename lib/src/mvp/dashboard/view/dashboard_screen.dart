// ignore_for_file: public_member_api_docs, always_declare_return_types, lines_longer_than_80_chars

import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/provider/home_provider.dart';
import 'package:bb3_ecommerce_app/src/mvp/dashboard/home/view/home_screen.dart';
import 'package:bb3_ecommerce_app/src/mvp/network/provider/global_provider.dart';
import 'package:bb3_ecommerce_app/src/widget/image/custom_image_view.dart';
import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

///Class For Dashboard class
class DashBoardData {
  ///Constructor For Dashboard Data
  DashBoardData({required this.activeIcon, required this.lable});

  final String activeIcon;
  final String lable;
}

///Change the index of bottom bar menu
class DashboardArgs {
  DashboardArgs({this.isNeedToShowAppOpen = false});
  final bool isNeedToShowAppOpen;
}

///Dashboard screen
class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({this.dashboardArgs, super.key});
  final DashboardArgs? dashboardArgs;

  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var globalProvider = Provider.of<GlobalProvider>(context, listen: false);
      globalProvider.isSplashScreen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, HomeProvider homeProvider, _) {
      return Scaffold(
        backgroundColor: VariableUtilities.theme.backgroundColor,
        body: PageView(
          controller: homeProvider.dashboardPageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            HomeScreen(),
          ],
          onPageChanged: (value) {
            setState(() {
              selectedIndex = value;
              homeProvider.dashboardPageController.jumpToPage(value);
            });
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0XFFD8407D),
          elevation: 10,
          currentIndex: selectedIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedItemColor: VariableUtilities.theme.whiteColor,
          unselectedItemColor: VariableUtilities.theme.whiteColor.withOpacity(0.4),
          selectedLabelStyle: FontUtilities.h12(fontColor: VariableUtilities.theme.whiteColor),
          unselectedLabelStyle: FontUtilities.h10(fontColor: VariableUtilities.theme.primaryColor),
          onTap: (int index) {
            setState(() {
              FocusScope.of(context).unfocus();
              selectedIndex = index;
              homeProvider.dashboardPageController.jumpToPage(index);
            });
          },
          type: BottomNavigationBarType.fixed,
          items: List.generate(
              homeProvider.bottomBarIconList.length,
              (index) => BottomNavigationBarItem(
                    icon: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: CustomImageView(
                        imageUrl: homeProvider.bottomBarIconList[index]['img'] ?? '',
                        height: selectedIndex == index ? 15.h : 13.h,
                        color: selectedIndex == index ? VariableUtilities.theme.whiteColor : VariableUtilities.theme.whiteColor.withOpacity(0.4),
                      ),
                    ),
                    label: homeProvider.bottomBarIconList[index]['name'] ?? '',
                  )),
        ),
      );
    });
  }
}
