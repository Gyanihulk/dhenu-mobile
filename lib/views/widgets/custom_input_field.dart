import 'package:dhenu_dharma/utils/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomInputField extends StatefulWidget {
  final String? label;
  final String hint;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChangeText;
  final TextInputType inputType;
  final IconData? prefixIcon;
  final Color prefixIconColor;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;

  const CustomInputField({
    Key? key,
    this.label,
    required this.hint,
    required this.controller,
    this.validator,
    this.onChangeText,
    this.inputType = TextInputType.text,
    this.prefixIcon,
    this.prefixIconColor = AppColors.secondary,
    this.obscureText = false,
    this.maxLines,
    this.minLines,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool _isObscured = true;

  void _toggleVisibility() {
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        onChanged: widget.onChangeText,
        keyboardType: widget.inputType,
        obscureText: widget.obscureText ? _isObscured : false,
        maxLines: widget.obscureText ? 1 : widget.maxLines,
        minLines: widget.minLines,
        decoration: InputDecoration(
          labelText: widget.label,
          hintText: widget.hint,
          hintStyle: TextStyle(
            fontSize: 12.h,
            color: AppColors.secondaryGrey,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: widget.prefixIconColor,
                )
              : null,
          suffixIcon: widget.obscureText
              ? IconButton(
                  icon: Icon(
                    _isObscured ? Icons.visibility : Icons.visibility_off,
                    color: AppColors.secondary,
                  ),
                  onPressed: _toggleVisibility,
                )
              : null,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.h),
            borderSide: const BorderSide(
              color: Color(0XFFAAAAAA),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.h),
            borderSide: const BorderSide(
              color: AppColors.secondary,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.h),
            borderSide: const BorderSide(
              color: Color(0XFFAAAAAA),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6.h),
            borderSide: const BorderSide(
              color: Colors.red,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
