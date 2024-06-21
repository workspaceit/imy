import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ilu/app/core/utils/app_colors.dart';

class CustomTextFormField extends StatefulWidget {
  // [cursorColor] represents the color of the text field cursor.
  final Color cursorColor;

  // [textEditingController] helps the users to modify the text field with associated [TextEditingController]
  final TextEditingController? textEditingController;

  // [textInputType] helps what kind of value you want to insert within text field
  final TextInputType textInputType;

  // [textInputAction]
  final TextInputAction textInputAction;

  // [hintText]
  final String hintText;

  // [prefixIcon]
  final Widget? prefixIcon;

  // [suffixIcon]
  final Widget? suffixIcon;

  // [onTap]
  final Function()? onTap;

  // [formValidator]
  final FormFieldValidator? formValidator;

  // [readOnly]
  final bool readOnly;

  // [isPassword]
  final bool isPassword;

  // [fillColor]
  final Color fillColor;

  final Function(String)? onChanged;
  final int? maxLines;
  final double radius;

  final List<TextInputFormatter>? inputFormatter;

  const CustomTextFormField({
    this.cursorColor = AppColors.colorDarkA,
    this.textEditingController,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.next,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.onTap,
    this.isPassword = false,
    this.formValidator,
    this.readOnly = false,
    this.fillColor = AppColors.colorWhite,
    this.onChanged,
    this.maxLines,
    this.radius = 99,
    this.inputFormatter,
    super.key
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return widget.isPassword
        ? TextFormField(
            obscureText: obscureText,
            cursorColor: widget.cursorColor,
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            inputFormatters: widget.inputFormatter,
            style: GoogleFonts.inter(
                color: AppColors.colorDarkA,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            decoration: InputDecoration(
                filled: true,
                fillColor: widget.fillColor,
                hintText: widget.hintText.tr,
                hintStyle: GoogleFonts.inter(
                    color: AppColors.colorDarkB,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(
                        color: AppColors.colorGrayB, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(
                        color: AppColors.colorGrayB, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(
                        color: AppColors.colorDarkA, width: 1)),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon),
            validator: widget.formValidator,
          )
        : TextFormField(
            readOnly: widget.readOnly,
            cursorColor: widget.cursorColor,
            controller: widget.textEditingController,
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            onChanged: widget.onChanged,
            maxLines: widget.maxLines,
            inputFormatters: widget.inputFormatter,
            style: GoogleFonts.inter(
                color: AppColors.colorDarkA,
                fontWeight: FontWeight.w400,
                fontSize: 14),
            decoration: InputDecoration(
                filled: true,
                fillColor: widget.fillColor,
                hintText: widget.hintText.tr,
                labelStyle: GoogleFonts.inter(
                    color: AppColors.colorDarkB,
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(
                        color: AppColors.colorGrayB, width: 1)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(
                        color: AppColors.colorGrayB, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(widget.radius),
                    borderSide: const BorderSide(
                        color: AppColors.colorDarkA, width: 1)),
                prefixIcon: widget.prefixIcon,
                suffixIcon: widget.suffixIcon),
            onTap: widget.onTap,
            validator: widget.formValidator,
          );
  }

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}
