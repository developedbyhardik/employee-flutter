import 'package:cosmocloud/constants/size.dart';
import 'package:cosmocloud/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomTextField extends StatefulWidget {
  final IconData icon;
  final String? hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextCapitalization? textCapitalization;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextField({
    Key? key,
    required this.icon,
    this.hintText,
    this.onChanged,
    this.controller,
    this.validator,
    this.keyboardType,
    this.textCapitalization,
    this.inputFormatters,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = false;

  @override
  void initState() {
    _obscureText = widget.keyboardType == TextInputType.visiblePassword;
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(
              0, AppSize.smallSpace, AppSize.smallSpace, AppSize.smallSpace),
          child: widget.hintText != null
              ? Text(widget.hintText.toString(),
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontFamily: "CircularStd-Medium"))
              : const SizedBox(),
        ),
        Container(
          constraints: const BoxConstraints(minHeight: 50),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(AppSize.mediumBorderRadius / 2),
          ),
          padding: EdgeInsets.zero,
          margin: EdgeInsets.zero,
          child: TextFormField(
            inputFormatters: widget.inputFormatters,
            cursorColor: Theme.of(context).colorScheme.onPrimary,
            textCapitalization:
                widget.textCapitalization ?? TextCapitalization.none,
            keyboardType: widget.keyboardType,
            decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(
                    0, AppSize.smallSpace * 1.5, 0, AppSize.smallSpace * 1.5),
                suffixIcon: widget.keyboardType == TextInputType.visiblePassword
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(
                          _obscureText
                              ? PhosphorIcons.eye()
                              : PhosphorIcons.eyeSlash(),
                          // color: Palette.white,
                        ),
                      )
                    : null,
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.blue, width: 1.5),
                  // borderRadius: BorderRadius.circular(15),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent, width: 1.5),
                  // borderRadius: BorderRadius.circular(15),
                ),
                focusedErrorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.red, width: 1.5),
                  // borderRadius: BorderRadius.circular(15),
                ),
                errorBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Palette.red, width: 1.5),
                  // borderRadius: BorderRadius.circular(15),
                ),
                errorStyle: const TextStyle(
                  color: Palette.red,
                ),
                // fillColor: Palette.white,
                border: InputBorder.none,
                prefixIcon: Icon(
                  widget.icon,
                  // color: Palette.white,
                ),
                hintText: widget.hintText,
                // labelText: widget.hintText,
                labelStyle: const TextStyle(
                  color: Palette.grey,
                ),
                hintStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Palette.grey,
                      fontFamily: "CircularStd-Book",
                    )),
            obscureText: _obscureText,
            validator: widget.validator,
            controller: widget.controller,
            onChanged: widget.onChanged,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  // color: Palette.white,
                  fontFamily: "CircularStd-Book",
                ),
          ),
        ),
      ],
    );
  }
}
