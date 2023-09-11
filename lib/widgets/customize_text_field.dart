import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:katarasa/utils/constant.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField(
      {super.key,
      this.inputFormatters,
      this.autoFocus = false,
      this.enabled,
      this.controller,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.onFieldSubmitted,
      this.hintText,
      this.labelText,
      this.hintStyle,
      this.textCapitalization = TextCapitalization.none,
      this.keyboardType,
      this.maxLines = 1,
      this.textInputAction,
      this.suffixIcon,
      this.prefix,
      this.obscureText = false});

  final bool? autoFocus;
  final bool? enabled;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final Function(String)? onFieldSubmitted;
  final String? hintText;
  final String? labelText;
  final TextStyle? hintStyle;
  final TextCapitalization textCapitalization;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final int? maxLines;
  final Widget? suffixIcon;
  final Widget? prefix;
  final bool obscureText;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  FocusNode? _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    super.dispose();
    _focusNode = FocusNode();
  }

  void _requestFocus() {
    setState(() {
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: widget.enabled,
      controller: widget.controller,
      autofocus: widget.autoFocus!,
      validator: widget.validator,
      onChanged: widget.onChanged,
      textInputAction: widget.textInputAction,
      textCapitalization: widget.textCapitalization,
      onFieldSubmitted: widget.onFieldSubmitted,
      cursorColor: ColorUI.BROWN,
      cursorWidth: 2,
      cursorHeight: 25,
      maxLines: widget.maxLines,
      style: const TextStyle(fontSize: 14),
      decoration: InputDecoration(
        errorStyle: const TextStyle(fontSize: 13),
        suffixIcon: widget.suffixIcon,
        prefix: widget.prefix,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
        fillColor: ColorUI.WHITE,
        filled: true,
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide:
                BorderSide(width: 2, color: ColorUI.BROWN.withOpacity(.50))),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: ColorUI.BROWN.withOpacity(.60))),
        hintText: widget.hintText,
        hintStyle: LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14),
        labelText: widget.labelText,
        labelStyle: _focusNode!.hasFocus
            ? BROWN_TEXT_STYLE.copyWith(fontSize: 14)
            : LIGHT_BROWN_TEXT_STYLE.copyWith(fontSize: 14),
      ),
      focusNode: _focusNode,
      onSaved: widget.onSaved,
      keyboardType: widget.keyboardType,
      obscureText: widget.obscureText,
      inputFormatters: widget.inputFormatters,
      onTap: _requestFocus,
    );
  }
}
