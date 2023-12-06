import 'package:flutter/material.dart';
import 'package:lang_s_application4/core/app_export.dart';

class CustomSearchView extends StatefulWidget {
  final Alignment? alignment;
  final double? width;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool? autofocus;
  final TextStyle? textStyle;
  final TextInputType? textInputType;
  final int? maxLines;
  final String? hintText;
  final TextStyle? hintStyle;
  final Widget? prefix;
  final BoxConstraints? prefixConstraints;
  final Widget? suffix;
  final BoxConstraints? suffixConstraints;
  final EdgeInsets? contentPadding;
  final InputBorder? borderDecoration;
  final Color? fillColor;
  final bool? filled;
  final FormFieldValidator<String>? validator;
  final Function(String)? onChanged;

  CustomSearchView({
    Key? key,
    this.alignment,
    this.width,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.textInputType,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = true,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomSearchViewState createState() => _CustomSearchViewState();
}

class _CustomSearchViewState extends State<CustomSearchView> {
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController();
    // Check if the initial text is empty, if yes, disable autofocus
    if (widget.controller?.text.isEmpty ?? true) {
      widget.focusNode?.unfocus();
    }
  }

  @override
  void dispose() {
    _internalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.alignment != null
        ? Align(
      alignment: widget.alignment ?? Alignment.center,
      child: searchViewWidget,
    )
        : searchViewWidget;
  }

  Widget get searchViewWidget => SizedBox(
    width: widget.width ?? double.maxFinite,
    child: TextFormField(
      controller: _internalController,
      focusNode: widget.focusNode ?? FocusNode(),
      autofocus: widget.autofocus!,
      style: widget.textStyle ?? CustomTextStyles.bodyLargeBluegray500,
      keyboardType: widget.textInputType,
      maxLines: widget.maxLines ?? 1,
      decoration: _buildDecoration(),
      validator: widget.validator,
      onChanged: (String value) {
        widget.onChanged?.call(value);
      },
    ),
  );

  InputDecoration _buildDecoration() {
    InputDecoration baseDecoration = InputDecoration(
      hintText: widget.hintText ?? "",
      hintStyle: widget.hintStyle ?? CustomTextStyles.bodyLargeBluegray500,
      prefixIcon: widget.prefix ??
          Container(
            margin: EdgeInsets.fromLTRB(14.h, 12.v, 8.h, 12.v),
            child: CustomImageView(
              imagePath: ImageConstant.imgSearch,
              height: 20.adaptSize,
              width: 20.adaptSize,
            ),
          ),
      prefixIconConstraints: widget.prefixConstraints ??
          BoxConstraints(
            maxHeight: 44.v,
          ),
      suffixIcon: widget.suffix ??
          Padding(
            padding: EdgeInsets.only(
              right: 15.h,
            ),
            child: IconButton(
              onPressed: () => _internalController.clear(),
              icon: Icon(
                Icons.clear,
                color: Colors.grey.shade600,
              ),
            ),
          ),
      suffixIconConstraints: widget.suffixConstraints ??
          BoxConstraints(
            maxHeight: 44.v,
          ),
      isDense: true,
      contentPadding: widget.contentPadding ??
          EdgeInsets.only(
            top: 12.v,
            right: 12.h,
            bottom: 12.v,
          ),
      fillColor: widget.fillColor ?? theme.colorScheme.primary,
      filled: widget.filled,
      border: widget.borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: appTheme.blueGray100,
              width: 1,
            ),
          ),
      enabledBorder: widget.borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: appTheme.blueGray100,
              width: 1,
            ),
          ),
      focusedBorder: widget.borderDecoration ??
          OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.h),
            borderSide: BorderSide(
              color: appTheme.blueGray100,
              width: 1,
            ),
          ),
    );

    // Check if autofocus is enabled, if yes, override the prefixIcon with an empty container
    return widget.autofocus! ? baseDecoration.copyWith(prefixIcon: Container()) : baseDecoration;
  }
}
