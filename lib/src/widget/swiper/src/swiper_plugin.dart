// import 'package:flutter/widgets.dart';
// import 'package:provider_app/src/widget/swiper/flutter_swiper.dart';

// /// plugin to display swiper components
// ///
// abstract class SwiperPlugin {
//   const SwiperPlugin();

//   Widget build(BuildContext context, SwiperPluginConfig config);
// }

// class SwiperPluginConfig {
//   final int? activeIndex;
//   final int? itemCount;
//   final Axis? scrollDirection;
//   final bool? loop;
//   final bool? outer;
//   final PageController? pageController;
//   final SwiperController? controller;
//   final SwiperLayout? layout;

//   const SwiperPluginConfig(
//       {this.activeIndex,
//       this.itemCount,
//       this.outer,
//       this.scrollDirection,
//       this.controller,
//       this.pageController,
//       this.layout,
//       this.loop = false})
//       : assert(scrollDirection != null),
//         assert(controller != null);
// }

// class SwiperPluginView extends StatelessWidget {
//   final SwiperPlugin plugin;
//   final SwiperPluginConfig config;

//   const SwiperPluginView(this.plugin, this.config);

//   @override
//   Widget build(BuildContext context) {
//     return plugin.build(context, config);
//   }
// }
