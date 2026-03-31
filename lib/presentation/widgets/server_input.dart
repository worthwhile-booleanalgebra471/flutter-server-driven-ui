import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';

typedef InputChangeCallback = void Function(String id, String value);

Widget buildServerInput(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild, {
  InputChangeCallback? onChanged,
}) {
  final label = node.props['label'] as String? ?? '';
  final hint = node.props['hint'] as String? ?? '';
  final maxLines = (node.props['maxLines'] as num?)?.toInt() ?? 1;
  final keyboardType = _parseKeyboardType(node.props['keyboardType'] as String?);
  final validation = node.props['validation'] as Map<String, dynamic>?;

  return _ServerInputField(
    id: node.id ?? '',
    label: label,
    hint: hint,
    maxLines: maxLines,
    keyboardType: keyboardType,
    onChanged: onChanged,
    validation: validation != null ? _InputValidation.fromJson(validation) : null,
  );
}

class _InputValidation {
  final bool required;
  final int? minLength;
  final int? maxLength;
  final String? pattern;
  final String? message;

  const _InputValidation({
    this.required = false,
    this.minLength,
    this.maxLength,
    this.pattern,
    this.message,
  });

  factory _InputValidation.fromJson(Map<String, dynamic> json) {
    return _InputValidation(
      required: json['required'] as bool? ?? false,
      minLength: (json['minLength'] as num?)?.toInt(),
      maxLength: (json['maxLength'] as num?)?.toInt(),
      pattern: json['pattern'] as String?,
      message: json['message'] as String?,
    );
  }

  String? validate(String value) {
    if (required && value.trim().isEmpty) {
      return message ?? 'This field is required';
    }
    if (minLength != null && value.length < minLength!) {
      return message ?? 'Minimum $minLength characters';
    }
    if (maxLength != null && value.length > maxLength!) {
      return message ?? 'Maximum $maxLength characters';
    }
    if (pattern != null && value.isNotEmpty) {
      final regex = RegExp(pattern!);
      if (!regex.hasMatch(value)) {
        return message ?? 'Invalid format';
      }
    }
    return null;
  }
}

class _ServerInputField extends StatefulWidget {
  final String id;
  final String label;
  final String hint;
  final int maxLines;
  final TextInputType keyboardType;
  final InputChangeCallback? onChanged;
  final _InputValidation? validation;

  const _ServerInputField({
    required this.id,
    required this.label,
    required this.hint,
    required this.maxLines,
    required this.keyboardType,
    this.onChanged,
    this.validation,
  });

  @override
  State<_ServerInputField> createState() => _ServerInputFieldState();
}

class _ServerInputFieldState extends State<_ServerInputField> {
  String? _errorText;
  bool _touched = false;

  void _onChanged(String value) {
    widget.onChanged?.call(widget.id, value);
    if (_touched && widget.validation != null) {
      setState(() => _errorText = widget.validation!.validate(value));
    }
  }

  void _onFocusLost(String value) {
    _touched = true;
    if (widget.validation != null) {
      setState(() => _errorText = widget.validation!.validate(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      textField: true,
      label: widget.label,
      child: Focus(
        onFocusChange: (hasFocus) {
          if (!hasFocus) {
            _onFocusLost(_controller.text);
          }
        },
        child: TextField(
          controller: _controller,
          maxLines: widget.maxLines,
          keyboardType: widget.keyboardType,
          maxLength: widget.validation?.maxLength,
          decoration: InputDecoration(
            labelText: widget.label,
            hintText: widget.hint,
            border: const OutlineInputBorder(),
            errorText: _errorText,
          ),
          onChanged: _onChanged,
        ),
      ),
    );
  }

  late final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

TextInputType _parseKeyboardType(String? value) {
  return switch (value) {
    'emailAddress' => TextInputType.emailAddress,
    'number' => TextInputType.number,
    'phone' => TextInputType.phone,
    'multiline' => TextInputType.multiline,
    'url' => TextInputType.url,
    _ => TextInputType.text,
  };
}
