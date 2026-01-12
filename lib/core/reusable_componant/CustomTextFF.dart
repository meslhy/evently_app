import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool isPassword;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;



  const CustomTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isPassword = false,
    this.validator,
    this.prefixIcon,
    this.hint ="",
  });

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      maxLines: widget.keyboardType == TextInputType.multiline ? 5 : 1,
      keyboardType: widget.keyboardType,
      obscureText: widget.isPassword ? _obscureText : false,
      validator: widget.validator,
      textAlignVertical: TextAlignVertical.top,
      decoration: InputDecoration(
        labelText: widget.label,
        hint: Text(widget.hint),
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.isPassword
            ? IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () {
            setState(() {
              _obscureText = !_obscureText;
            });
          },
        )
            : null,
        contentPadding: const EdgeInsets.symmetric(
          vertical: 20,
        ),
        border: OutlineInputBorder(

          borderSide: BorderSide(
            color: Colors.grey
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
