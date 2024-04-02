import 'package:flutter/material.dart';
class TextFormFieldCustom extends StatelessWidget {
 final Color? textColor;
 final Color? borderColor;
 final Color? labelStyleColor;
 final String? label;
 final String? hintText;
 final bool obscure;
 final int maxLinse;
 final  TextEditingController? controller;
 final String? Function(String?)? validator;
 final void Function(String)? onChanged;
 final void Function()? onTap;
 final InputBorder? focusedBorder;
final TextInputType? keyboardType;
final TextInputAction? textInputAction;
  const TextFormFieldCustom({this.textColor,
    this.borderColor,
    this.labelStyleColor,
    this.label,
    this.hintText,
    this.obscure = false,
    this.validator,
    this.onChanged,
    this.maxLinse = 1,
     this.controller,
    this.onTap,
    this.focusedBorder,
    this.keyboardType,
    this.textInputAction =TextInputAction.next,
    super.key});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: textInputAction,
      keyboardType:keyboardType ,
      onTap: onTap,
      validator: validator,
      controller:controller ,
      maxLines: maxLinse,
       onChanged: onChanged,
      style: TextStyle(
        color: textColor,
      ),
      decoration: InputDecoration(
         focusedBorder:focusedBorder,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor!),
        ),
        label: Text(label ?? 'null'),
        labelStyle: TextStyle(color: labelStyleColor!),
        hintText: hintText ?? '',
      ),
      obscureText: obscure,
    );
  }
}
