import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:fluttertoast/fluttertoast.dart' as toast;
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:find_cook/common/widgets/text_view.dart';

import '../../core/theme/pallets.dart';
import 'image_widget.dart';

class CustomDialogs {

  static void showLogout(
      BuildContext context, {
        UniqueKey? key,
        String message = '',
        Color? barrierColor,
        bool? useRootNavigator = false,
      }) async {
    final dialog = Dialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10),
      ),
      key: key,
      backgroundColor: Pallets.white,
      elevation: 0,
      // child: PulsatingImage(),

      child:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextView(text: "Logging Out....",fontSize: 15,fontWeight: FontWeight.w600,),
            10.verticalSpace,
            SpinKitCubeGrid(
              color:Color(0xffE67002).withOpacity(0.6),
              size: 30.0,
            ),
          ],
        ),
      ),
    );

    await showDialog(
      context: context,
      useRootNavigator: useRootNavigator!,
      builder: (BuildContext context) => dialog,
      barrierDismissible: true,
      barrierColor: barrierColor ?? Pallets.successGreen.withOpacity(0.1),
      // barrierColor: barrierColor,
    );
  }


  static void showLoading(
    BuildContext context, {
    UniqueKey? key,
    String message = '',
    Color? barrierColor,
    bool? useRootNavigator = false,
  }) async {
    final dialog = Dialog(
      key: key,
      backgroundColor: Colors.transparent,
      elevation: 0,
      // child: PulsatingImage(),

      child:  SpinKitCubeGrid(
        color:Color(0xffE67002).withOpacity(0.6),
        size: 50.0,
      ),
    );

    await showDialog(
      context: context,
      useRootNavigator: useRootNavigator!,
      builder: (BuildContext context) => dialog,
      barrierDismissible: true,
      barrierColor: barrierColor ?? Pallets.successGreen.withOpacity(0.1),
      // barrierColor: barrierColor,
    );
  }

  static Future<T?> showBottomSheet<T>(BuildContext context, Widget child,
      {Color? barrierColor}) {
    return showModalBottomSheet<T>(
        backgroundColor: Colors.transparent,
        enableDrag: true,
        context: context,
        barrierColor: barrierColor ?? Pallets.blue.withOpacity(0.3),
        useRootNavigator: true,
        isScrollControlled: true,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: child,
          );
        });
  }

  static void showConfirmDialog(
    BuildContext context, {
    String message = '',
    String tittle = 'Password Updated\nSuccessfully!',
    String confirmText = 'Confirm',
    String cancelText = 'Cancel',
    VoidCallback? onYes,
    VoidCallback? onCancel,
    Color? confirmButtonBgColor,
    String? image,
  }) async {
    final dialog = Dialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        // height: 260,
        width: 200,
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10,),

                InkWell(
                  onTap: (){
                    context.pop();
                  },
                    child: Icon(Icons.clear,))
              ],
            ),
            image != null
                ? Center(
                    child: ImageWidget(
                      imageUrl: image,
                      size: 50,
                    ),
                  )
                : const SizedBox.shrink(),
            10.verticalSpace,
            Center(
              child: TextView(
                align: TextAlign.center,
                text: tittle,
                style: GoogleFonts.sora(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            Center(
              child: TextView(
                text: message,
                fontSize: 12,
                color: Pallets.grey,
                align: TextAlign.center,
              ),
            ),
            30.verticalSpace,
            // const CustomDivider(),
            // 10.verticalSpace,
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // Expanded(
            //     //   child: ButtonDialog(
            //     //     title: cancelText,
            //     //     isInverted: true,
            //     //     onTap: () {
            //     //       if (onCancel != null) {
            //     //         onCancel();
            //     //       } else {
            //     //         hideLoading(context);
            //     //       }
            //     //     },
            //     //   ),
            //     // ),
            //     10.horizontalSpace,

            //     Expanded(
            //       child: ButtonDialog(
            //         bgColor: confirmButtonBgColor,
            //         title: confirmText,
            //         onTap: onYes,
            //       ),
            //     ),
            //   ],
            // ),
            Center(
              child: ButtonDialog(
                bgColor: Color(0xf9b00000),
                title: confirmText,
                onTap: onYes,
              ),
            ),
          ],
        ),
      ),
    );

    await showDialog(
      context: context,
      builder: (BuildContext context) => Builder(builder: (context) {
        return dialog;
      }),
      barrierDismissible: true,
    );
  }

  static Future showCustomDialog(Widget child, BuildContext context,
      {String title = 'loading...',
      VoidCallback? onYes,
      bool? useRootNavigator = false,
      bool? barrierDismissible = true}) async {
    final dialog = Dialog(
      backgroundColor: Pallets.white,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(borderRadius: BorderRadius.circular(12), child: child),
    );

    return showDialog(
      context: context,
      useRootNavigator: useRootNavigator!,
      builder: (BuildContext context) => dialog,
      barrierDismissible: barrierDismissible!,
      barrierColor: Pallets.black.withOpacity(0.2),
    );
  }

  static showOverlayDialog(
    BuildContext context, {
    required Widget? child,
    bool? dissmisable = true,
    double? opacity = 0.8,
  }) {
    showDialog(
        context: context,
        barrierDismissible: dissmisable!,
        barrierColor: Colors.black.withOpacity(opacity!),
        builder: (context) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if ((child != null)) ...[child],
                if ((child == null)) ...[
                  CupertinoActivityIndicator(
                    color: Theme.of(context).colorScheme.onPrimary,
                    radius: 15,
                  ),
                ]
              ],
            ),
          );
        });
  }

  static Future<DateTime?> selectDate(
      DateTime initialDate, BuildContext context,
      {DateTime? minDate, String? text = ""}) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        DateTime? _selectedDate;
        return Dialog(
          child: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 200.0,
                  child: CupertinoDatePicker(
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: minDate,
                    maximumDate: minDate,
                    onDateTimeChanged: (DateTime newDateTime) {
                      _selectedDate = newDateTime;
                    },
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CupertinoButton(
                      child: const TextView(
                        text: 'Cancel',
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    CupertinoButton(
                      child: TextView(
                        text: 'Select date',
                      ),
                      onPressed: () {
                        Navigator.of(context).pop(_selectedDate);
                      },
                    ),
                  ],
                ),
                10.verticalSpace
              ],
            ),
          ),
        );
      },
    );
  }

  static void hideLoading(BuildContext context) {
    // if (dialogKey.currentContext != null) {
    // Future.delayed(Duration.zero, () {
    //
    // });

    isThereCurrentDialogShowing(BuildContext context) =>
        ModalRoute.of(context)?.isCurrent != true;

    if (isThereCurrentDialogShowing(context)) {
      context.pop();
    }

    // } else {
    // Future.delayed(const Duration.zero ,() {})
    //     .then((value) => Navigator.of(context).pop());
    // }
  }

  static Widget getLoading({double size = 10.0}) => Container(
        alignment: Alignment.center,
        color: Colors.transparent,
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: SpinKitCubeGrid(
          color:Color(0xffE67002).withOpacity(0.6),
          size: 50.0,
        ),
      );

  static void showSnackBar(
    BuildContext context,
    String message, {
    void Function()? onClose,
    bool error = false,
  }) {
    final snackBar = SnackBar(
      content: TextView(text: message),
      backgroundColor: !error ? Pallets.primary : Colors.red,
      duration: const Duration(seconds: 5),
      action: SnackBarAction(
        label: 'CLOSE',
        textColor: Colors.white,
        onPressed: () {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          if (onClose != null) {
            onClose();
          }
        },
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  /// show success notification
  static success(String message) {
    // show a notification at top of screen.
    showSimpleNotification(
      duration: const Duration(seconds: 3),
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Pallets.successGreen,
          border: Border.all(color: Pallets.successGreen),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle,
              size: 24.0,
              color: Pallets.white,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextView(
                text: message.isNotEmpty
                    ? message
                    : 'Network error, please try again',
                fontSize: 14,
                color: Pallets.white,
                fontWeight: FontWeight.w500,
                maxLines: 2,
                textOverflow: TextOverflow.ellipsis,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      background: Colors.transparent,
      elevation: 0,
    );
  }

  /// show error notification
  static error(String message) {
    // show a notification at top of screen.

    // show a notification at top of screen.
    showSimpleNotification(
      duration: const Duration(seconds: 5),
      slideDismissDirection: DismissDirection.vertical,
      Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Pallets.red,
          // border: Border.all(color: Pallets.red),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.info,
              size: 24.0,
              color: Pallets.white,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: TextView(
                text: message.isEmpty
                    ? 'An error occurred, please try again'
                    : message,
                fontSize: 15,
                color: Pallets.white,
                fontWeight: FontWeight.w500,
                maxLines: 3,
                textOverflow: TextOverflow.ellipsis,
                align: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
      background: Colors.transparent,
      elevation: 0,
    );
  }

  static void showToast(String message, {bool isError = false}) async {
    await toast.Fluttertoast.showToast(
      msg: message,
      toastLength: toast.Toast.LENGTH_LONG,
      gravity: toast.ToastGravity.BOTTOM,
      backgroundColor: isError ? Pallets.red : Pallets.primary,
      textColor: Pallets.white,
      fontSize: 16,
    );
  }

  static void showFlushBar(BuildContext context, String message,
      {bool isError = false}) async {
    if (isError) {
      showSimpleNotification(
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Pallets.primaryLight,
            border: Border.all(color: Pallets.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 24.0,
                color: Pallets.primary,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: TextView(
                  text: message.isEmpty
                      ? 'An error occurred, please try again'
                      : message,
                  fontSize: 14,
                  color: Pallets.primary,
                  fontWeight: FontWeight.w500,
                  maxLines: 2,
                  textOverflow: TextOverflow.ellipsis,
                  align: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
        background: Colors.transparent,
        elevation: 0,
      );
    } else {
      Flushbar(
        message: message,
        messageColor: Pallets.primary,
        icon: Icon(
          Icons.check_circle,
          size: 24.0,
          color: Pallets.primary,
        ),
        shouldIconPulse: false,
        borderWidth: .5,
        borderColor: Pallets.primary,
        backgroundColor: Pallets.primaryLight,
        margin: EdgeInsets.all(8),
        flushbarPosition: FlushbarPosition.TOP,
        borderRadius: BorderRadius.circular(8),
        duration: Duration(seconds: 3),
      ).show(context);
    }
  }
}

class ButtonDialog extends StatelessWidget {
  const ButtonDialog({
    super.key,
    this.onTap,
    this.isInverted = false,
    required this.title,
    this.bgColor,
    this.fgColor,
  });

  final VoidCallback? onTap;
  final bool isInverted;
  final String title;
  final Color? bgColor;
  final Color? fgColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            side: isInverted ? const BorderSide(color: Pallets.grey90) : null,
            backgroundColor:
                isInverted ? Colors.transparent : bgColor ?? Pallets.primary,
            foregroundColor: isInverted
                ? Theme.of(context).colorScheme.onBackground
                : fgColor ?? Pallets.white),
        onPressed: onTap,
        child: TextView(
          text: title,
          style: GoogleFonts.sora(
              fontSize: 16.sp,
              fontWeight: FontWeight.w400,
              color: Colors.white),
        ));
  }
}

class PulsatingImage extends StatefulWidget {
  const PulsatingImage({super.key});

  @override
  _PulsatingImageState createState() => _PulsatingImageState();
}

class _PulsatingImageState extends State<PulsatingImage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  var scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      upperBound: 0.8,
      lowerBound: 0.3,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    scaleAnimation = Tween(
      begin: 0.5,
      end: 1.0,
    ).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.easeIn));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,

      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.accountVerified * 0.4 + 0.2,
          child: child,
        );
      },
      child: Center(
        child: Image.asset(
          ' Assets.images.svgs.onboarding1,',
          width: 130,
          height: 130,
        ),
      ), // Replace with your image path
    );
  }
}
