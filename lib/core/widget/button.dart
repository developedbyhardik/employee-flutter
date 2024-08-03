import 'package:cosmocloud/constants/size.dart';
import 'package:cosmocloud/theme/palette.dart';
import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final Function()? onPressed;
  final Color? color;
  final Color? borderColor;
  final Widget text;
  final bool? isLoading;
  final bool? isDisable;
  final Widget? icon;

  const LargeButton({
    Key? key,
    this.onPressed,
    this.color,
    this.borderColor,
    this.isLoading,
    required this.text,
    this.isDisable,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSize.mediumBorderRadius * 5),
          side: BorderSide(
            color: borderColor ?? Colors.transparent,
            width: 2,
          ),
        ),
        backgroundColor: color ??
            (isDisable != null && isDisable == true
                ? Palette.grey
                : Palette.primaryBlue),
        padding: const EdgeInsets.symmetric(
          horizontal: 0,
          vertical: 14,
        ),
      ),
      onPressed: () {
        if (isDisable != null && isDisable == true) {
          return;
        }
        if (isLoading == null) {
          onPressed!();
        } else if (!isLoading!) {
          onPressed!();
        }
      },
      child: SizedBox(
        width: double.infinity,
        height: 35,
        child: Center(
          child: isLoading != null && isLoading!
              ? CircularProgressIndicator(
                  color: Colors.white,
                )
              : icon != null
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        text,
                        const SizedBox(width: 10),
                        icon!,
                      ],
                    )
                  : text,
        ),
      ),
    );
  }
}
