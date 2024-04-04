import 'package:flutter/material.dart';

import '../../../flutter_flow/flutter_flow_theme.dart'; // Make sure to import FlutterFlowTheme if it's not already imported

class HomePageTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool autofocus;
  final bool obscureText;
  final String labelText;
  final String hintText;
  final Function(String)? onChanged;
  final Function(String?)? validator;

  const HomePageTextField({
    super.key,
    required this.controller,
    this.autofocus = false,
    this.obscureText = false,
    required this.labelText,
    this.hintText = '',
    this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      obscureText: obscureText,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        labelStyle: FlutterFlowTheme.of(context).labelMedium.override(
              fontFamily: 'Readex Pro',
              fontSize: 14.0,
            ),
        hintStyle: FlutterFlowTheme.of(context).labelMedium,
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xFFFFF9E1),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).primary,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        focusedErrorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: FlutterFlowTheme.of(context).error,
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        filled: true,
        fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        prefixIcon: const Icon(Icons.search_rounded),
      ),
      style: FlutterFlowTheme.of(context).labelMedium.override(
            fontFamily: 'Readex Pro',
            fontSize: 12.0,
          ),
      validator: validator != null ? (value) => validator!(value) : null,
    );
  }
}
