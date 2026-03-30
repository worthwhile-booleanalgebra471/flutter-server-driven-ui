import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';

Widget buildServerChip(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final label = node.props['label'] as String? ?? '';
  final avatar = node.props['avatar'] as String?;
  final bgColor = _parseColor(node.props['backgroundColor'] as String?);
  final textColor = _parseColor(node.props['textColor'] as String?);
  final outlined = node.props['outlined'] as bool? ?? false;

  if (outlined) {
    return OutlinedButton(
      onPressed: node.action != null ? () {} : null,
      style: OutlinedButton.styleFrom(
        foregroundColor: textColor,
        side: bgColor != null ? BorderSide(color: bgColor) : null,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(label),
    );
  }

  return Chip(
    avatar: avatar != null
        ? CircleAvatar(
            backgroundColor: Colors.transparent,
            child: Text(avatar, style: const TextStyle(fontSize: 14)),
          )
        : null,
    label: Text(label),
    backgroundColor: bgColor,
    labelStyle: textColor != null ? TextStyle(color: textColor) : null,
  );
}

Color? _parseColor(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  final raw = hex.replaceFirst('#', '');
  if (raw.length == 6) return Color(int.parse('FF$raw', radix: 16));
  if (raw.length == 8) return Color(int.parse(raw, radix: 16));
  return null;
}
