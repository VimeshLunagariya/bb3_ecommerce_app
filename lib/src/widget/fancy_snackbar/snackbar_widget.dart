// ignore_for_file: always_put_required_named_parameters_first, lines_longer_than_80_chars

import 'dart:math';

import 'package:bb3_ecommerce_app/src/widget/image/custom_image_view.dart';
import 'package:bb3_ecommerce_app/utilities/asset/asset_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/font/font_utilities.dart';
import 'package:bb3_ecommerce_app/utilities/settings/variable_utilities.dart';
import 'package:flutter/material.dart';

///Snack bar type
enum SnackBarType {
  /// success.
  success,

  /// error.
  error,

  /// info.
  info,

  /// warning.
  warning,

  /// waiting
  waiting,
}

///Snackbar
class SnackbarWidget {
  ///Show Snackbar while Getting error or success response
  static void showSnackbar({
    required BuildContext context,

    /// duration is used to set the duration of snackbar to show on the screen.
    /// it will manage how long the snackbar will be showed in the screen.
    /// default duration is [2 seconds]
    double duration = 2,

    /// if you want to take any actions after closing the snackbar,
    /// then you can pass the callback.
    VoidCallback? onCloseEvent,

    /// there are many colors providing in the package.
    /// you can select shades of the colors from the enum.
    /// default color will be the color based on the type.
    Color? color,

    /// animationDuration handle how long you want to take
    /// while getting snackbar in the screen.
    /// default it is 800 milliseconds
    double animationDuration = 0.3,

    /// animationDuration handle how long you want to take while getting off
    /// snackbar from the screen.
    /// default it is 800 milliseconds
    double reverseAnimationDuration = 0.3,

    /// if there is the 'title' passed,
    /// then it will take the default style for it.
    /// default 'title' is based on the type selected.
    String? title,

    /// if you want to use your own style and text for the 'title'.
    /// then you can pass the 'titleWidget'.
    /// when you will pass the 'titleWidget',
    /// it will ignore the 'title' if you have passed.
    Widget? titleWidget,

    /// you can choose style for your snackbar based on the type.
    /// there are 5 types we are providing for now.
    /// 1. success
    /// 2. error
    /// 3. info
    /// 4. warning
    /// 5. waiting
    ///
    /// default type is success.
    SnackBarType snackBarType = SnackBarType.success,

    /// if there is the 'message' passed then,
    /// it will take the default style for it.
    /// default 'message' is based on the type selected.
    String? message,

    /// if you want to use your own style and text for the 'message'
    /// then you can pass the 'messageWidget'.
    /// when you will pass the 'messageWidget' it will ignore the 'message',
    /// if you have passed.
    Widget? messageWidget,
  }) async {
    /// creating new instance of OverlayEntry and using CustomSnackbar
    /// to render on the display using overlay.
    OverlayEntry d = OverlayEntry(
      builder: (context) {
        return CustomSnackbar(
          duration: duration,
          animationDuration: animationDuration,
          reverseAnimationDuration: reverseAnimationDuration,
          title: title,
          message: message,
          messageWidget: messageWidget,
          snackBarType: snackBarType,
          titleWidget: titleWidget,
          color: color,
        );
      },
    );

    /// inserting the new object in the widget tree
    /// to render the CustomSnackbar.
    Overlay.of(context).insert(d);

    /// it will show the snackbar for some time.
    await Future.delayed(Duration(milliseconds: (duration * 1000).toInt()));
    if (d.mounted) {
      /// after some delay it will remove the snackbar from display.
      d.remove();
    }
    if (onCloseEvent != null) {
      /// when onCloseEvent is not null then it will callback onCloseEvent.
      onCloseEvent();
    }
  }
}

class CustomSnackbar extends StatefulWidget {
  /// animationDuration handle how long you want to take while getting snackbar in the screen.
  /// default it is 800 milliseconds
  final double animationDuration;

  /// animationDuration handle how long you want to take while getting off snackbar from the screen.
  /// default it is 800 milliseconds
  final double reverseAnimationDuration;

  /// duration is used to set the duration of snackbar to show on the screen.
  /// it will manage how long the snackbar will be showed in the screen.
  /// default duration is [2 seconds]
  final double duration;

  /// if there is the 'title' passed then it will take the default style for it.
  /// default 'title' is based on the type selected.
  final String? title;

  /// if you want to use your own style and text for the 'title'.
  /// then you can pass the 'titleWidget'.
  /// when you will pass the 'titleWidget' it will ignore the 'title' if you have passed.
  final Widget? titleWidget;

  /// you can choose style for your snackbar based on the type.
  /// there are 5 types we are providing for now.
  /// 1. success
  /// 2. error
  /// 3. info
  /// 4. warning
  /// 5. waitting
  ///
  /// default type is success.
  final SnackBarType snackBarType;

  /// if there is the 'message' passed then it will take the default style for it.
  /// default 'message' is based on the type selected.
  final String? message;

  /// if you want to use your own style and text for the 'message'
  /// then you can pass the 'messageWidget'.
  /// when you will pass the 'messageWidget' it will ignore the 'message' if you have passed.
  final Widget? messageWidget;

  /// there are many colors providing in the package.
  /// you can select shades of the colors from the enum.
  /// default color will be the color based on the type.
  final Color? color;

  const CustomSnackbar({
    super.key,
    required this.animationDuration,
    required this.reverseAnimationDuration,
    required this.title,
    required this.titleWidget,
    required this.message,
    required this.messageWidget,
    required this.duration,
    required this.snackBarType,
    required this.color,
  });

  @override
  State<CustomSnackbar> createState() => _CustomSnackbarState();
}

class _CustomSnackbarState extends State<CustomSnackbar> with TickerProviderStateMixin {
  /// this is the animation controller for snackbar.
  late AnimationController _animationStartController;

  /// this is the animation for snackbar.
  late Animation _startAnimation;

  @override
  void initState() {
    super.initState();

    /// initializing the controller for snackbar.
    _animationStartController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: (widget.animationDuration * 1000).toInt(),
      ),
      reverseDuration: Duration(
        milliseconds: (widget.animationDuration * 1000).toInt(),
      ),
    );

    /// assigning the animation and linking with the controller of snackbar.
    _startAnimation = Tween<double>(begin: -60.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationStartController,
        curve: Curves.bounceInOut,
      ),
    );

    /// starting the animation to take snackbar in display.
    _animationStartController.forward().then((value) async {
      /// calculated the total waitting/holding duration.
      /// snackbar will hold on display for this duration.
      double displayDuration = widget.duration - (widget.animationDuration + widget.reverseAnimationDuration);

      /// after calucating the duration to hold make the snackbar holding on screen.
      /// and once the hold time is over getting snackbar off the screen with reverse animation.
      await Future.delayed(
        Duration(
          milliseconds: (displayDuration * 1000).toInt(),
        ),
      ).then((value) => _animationStartController.reverse());
    });
  }

  @override
  void dispose() {
    /// dispose both animation controller once this widget goes out from the widget tree.

    _animationStartController.dispose();

    super.dispose();
  }

  Random r = Random();

  /// this variable is used to randomly select the snackbar background shape.
  /// there are two shapes and it will select randomly from that two shapes.
  bool isFirstShape = true;
  @override
  Widget build(BuildContext context) {
    /// basic logical part to select random even number.
    isFirstShape = r.nextInt(100).isEven;
    return AnimatedBuilder(
        animation: _startAnimation,
        builder: (context, child) {
          return Container(
            alignment: Alignment(_startAnimation.value ?? 0.0, 0.95),
            child: Material(
              color: Colors.transparent,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(7),
                    ),
                    child: Container(
                      color: VariableUtilities.theme.whiteColor,
                      child: Container(
                        height: 70,
                        width: MediaQuery.of(context).size.width - 20,
                        decoration: BoxDecoration(
                          color: widget.snackBarType == SnackBarType.success
                              ? VariableUtilities.theme.color38D900.withOpacity(0.1)
                              : widget.snackBarType == SnackBarType.info
                                  ? VariableUtilities.theme.waitingColor.withOpacity(0.2)
                                  : VariableUtilities.theme.colorE06159.withOpacity(0.2),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(7),
                          ),
                        ),
                        child: Stack(
                          children: [
                            Container(
                              width: 6,
                              color: widget.snackBarType == SnackBarType.success
                                  ? VariableUtilities.theme.color38D900
                                  : widget.snackBarType == SnackBarType.info
                                      ? VariableUtilities.theme.waitingColor
                                      : VariableUtilities.theme.colorE06159,
                              // color: VariableUtilities.theme.color4FA332,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: CustomImageView(
                                      imageUrl: widget.snackBarType == SnackBarType.success
                                          ? AssetUtilities.successImg
                                          : widget.snackBarType == SnackBarType.error
                                              ? AssetUtilities.errorImg
                                              : AssetUtilities.successImg,
                                      height: 22,
                                      width: 24,
                                      color: widget.snackBarType == SnackBarType.success
                                          ? VariableUtilities.theme.color4FA332
                                          : widget.snackBarType == SnackBarType.error
                                              ? VariableUtilities.theme.colorE06159
                                              : VariableUtilities.theme.waitingColor,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        widget.titleWidget ??
                                            Text(
                                              widget.title ??
                                                  (widget.snackBarType == SnackBarType.success
                                                      ? 'Success'
                                                      : widget.snackBarType == SnackBarType.info
                                                          ? 'Information'
                                                          : 'Error'),
                                              style: FontUtilities.h16(
                                                  fontColor: widget.snackBarType == SnackBarType.success
                                                      ? VariableUtilities.theme.color4FA332
                                                      : widget.snackBarType == SnackBarType.error
                                                          ? VariableUtilities.theme.colorE06159
                                                          : VariableUtilities.theme.waitingColor,
                                                  fontWeight: FWT.semiBold),
                                            ),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: widget.messageWidget ??
                                                    Text(
                                                      widget.message ?? 'nothing in message',
                                                      overflow: TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                      style: FontUtilities.h12(fontColor: VariableUtilities.theme.color444444, fontWeight: FWT.semiBold),
                                                    )),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 19,
                                    width: 19,
                                    child: CustomImageView(
                                      imageUrl: AssetUtilities.cancelImg,
                                      color: widget.snackBarType == SnackBarType.success
                                          ? VariableUtilities.theme.color4FA332
                                          : widget.snackBarType == SnackBarType.error
                                              ? VariableUtilities.theme.colorE06159
                                              : VariableUtilities.theme.waitingColor,
                                      boxFit: BoxFit.cover,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
