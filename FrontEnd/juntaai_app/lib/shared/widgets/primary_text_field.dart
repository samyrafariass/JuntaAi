import 'package:flutter/material.dart';

class PrimaryTextField extends StatefulWidget {
  const PrimaryTextField({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.controller,
    this.icon,
    this.isPassword = false,
    this.labelStyle,
    this.hintStyle,
    this.labelGap = 8, // ⬅️ novo: gap entre label e campo (default 8)
  });

  final String labelText;
  final String hintText;
  final TextEditingController controller;
  final Widget? icon;
  final bool isPassword;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final double labelGap;

  @override
  State<PrimaryTextField> createState() => _PrimaryTextFieldState();
}

class _PrimaryTextFieldState extends State<PrimaryTextField> {
  bool _obscure = true;

  OutlineInputBorder _border(Color c) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(5),
    borderSide: BorderSide(color: c, width: 1),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: widget.labelStyle ?? const TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w400, fontSize: 12, height: 1.0, color: Colors.black),
        ),
        SizedBox(height: widget.labelGap),
        TextField(
          controller: widget.controller,
          obscureText: widget.isPassword ? _obscure : false,
          style: const TextStyle(fontFamily: 'Poppins', fontSize: 14, height: 1.0, color: Colors.black),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle:
                widget.hintStyle ??
                const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w400,
                  fontSize: 10,
                  color: Color(0x66000000), // #00000066
                ),
            prefixIcon: widget.icon == null
                ? null
                : Padding(
                    padding: const EdgeInsets.only(left: 16, right: 8),
                    child: IconTheme.merge(
                      data: const IconThemeData(size: 20, color: Color(0x66000000)),
                      child: widget.icon!,
                    ),
                  ),
            prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 20),
            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            enabledBorder: _border(Colors.black),
            focusedBorder: _border(Colors.black),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(_obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined, size: 20, color: Colors.black54),
                    onPressed: () => setState(() => _obscure = !_obscure),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
