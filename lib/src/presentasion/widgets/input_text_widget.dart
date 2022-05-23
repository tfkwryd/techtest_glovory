import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:techtest/src/config/colors/app_colors.dart';
import 'package:techtest/src/config/text_style/app_text_style.dart';

class InputTextWidget extends StatefulWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? title;
  final InputTextTitleType titleType;
  final IconData? icon;
  final double iconSize;
  final bool isBorder;
  final bool isRequired;
  final bool isHidden;
  final bool isFilled;
  final bool readOnly;
  final int maxLines;
  final int? maxLength;
  final double radius;
  final TextAlign textAlign;
  final TextInputType keyboardType;
  final List<TextInputFormatter> textInputFormatters;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final VoidCallback? onTap;
  const InputTextWidget({
    Key? key,
    this.controller,
    required this.hintText,
    this.title,
    this.isBorder = false,
    this.isRequired = false,
    this.isHidden = false,
    this.maxLines = 1,
    this.maxLength,
    this.icon,
    this.iconSize = 16,
    this.radius = 8,
    this.textAlign = TextAlign.start,
    this.keyboardType = TextInputType.text,
    this.textInputFormatters = const [],
    this.onChange,
    this.validator,
    this.onTap,
    this.readOnly = false,
    this.titleType = InputTextTitleType.inside,
    this.isFilled = false,
  }) : super(key: key);

  @override
  State<InputTextWidget> createState() => _InputTextWidgetState();
}

class _InputTextWidgetState extends State<InputTextWidget> {
  bool isHidden = false;
  int length = 0;
  @override
  void initState() {
    super.initState();
    isHidden = widget.isHidden;
  }

  @override
  Widget build(BuildContext context) {
    InputBorder _border = widget.isBorder
        ? OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(widget.radius),
            ),
            borderSide: BorderSide(
              color: AppColors.defaultTextColor.withOpacity(0.4),
              width: 1,
            ),
          )
        : UnderlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.defaultTextColor.withOpacity(0.4),
              width: 1,
            ),
          );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.titleType == InputTextTitleType.top && widget.title != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              (widget.title.toString() + (widget.isRequired ? ' ' : '')),
              style: AppTextStyle.headline4,
            ),
          ),
        TextFormField(
          readOnly: widget.readOnly,
          onTap: widget.onTap,
          keyboardType: widget.keyboardType,
          textAlign: widget.textAlign,
          maxLines: widget.maxLines,
          maxLength: widget.maxLength,
          controller: widget.controller,
          inputFormatters: widget.textInputFormatters,
          onChanged: widget.onChange,
          style: AppTextStyle.headline4.copyWith(
            fontWeight: FontWeight.w400,
          ),
          obscureText: isHidden,
          validator: widget.validator ??
              (value) {
                if (widget.isRequired) {
                  if (value == null || value == '') {
                    return "Inpute Can't be blank";
                  }
                }
                return null;
              },
          decoration: InputDecoration(
            filled: widget.isFilled,
            fillColor: AppColors.disableColor.withOpacity(0.3),
            isDense: true,
            prefixIcon: widget.icon != null
                ? Icon(
                    widget.icon,
                    size: widget.iconSize,
                    color: AppColors.defaultTextColor,
                  )
                : null,
            labelText: widget.titleType == InputTextTitleType.inside
                ? (widget.title != null
                    ? (widget.title.toString() +
                        (widget.isRequired ? ' *' : ''))
                    : null)
                : null,
            labelStyle: AppTextStyle.headline2.copyWith(
              height: 0.5,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            contentPadding: widget.isBorder
                ? const EdgeInsets.all(16)
                : const EdgeInsets.only(
                    bottom: 16,
                    top: 8,
                  ),
            border: _border,
            enabledBorder: _border,
            focusedBorder: _border,
            hintText: widget.hintText,
            hintStyle: AppTextStyle.headline4.copyWith(
              fontWeight: FontWeight.w400,
              color: AppColors.defaultTextColor.withOpacity(0.4),
            ),
            suffixIcon: (widget.isHidden
                ? GestureDetector(
                    onTap: () {
                      setState(() {
                        isHidden = !isHidden;
                      });
                    },
                    child: Icon(
                      !isHidden
                          ? CupertinoIcons.eye_fill
                          : CupertinoIcons.eye_slash_fill,
                      color: !isHidden
                          ? AppColors.defaultTextColor
                          : AppColors.defaultTextColor.withOpacity(0.4),
                      size: 24,
                    ),
                  )
                : null),
          ),
        ),
      ],
    );
  }
}

enum InputTextTitleType {
  top,
  inside,
}
