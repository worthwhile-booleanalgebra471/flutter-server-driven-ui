import 'package:flutter/material.dart';

import '../../core/models/screen_contract.dart';

Widget buildServerBadge(
  ComponentNode node,
  BuildContext context,
  Widget Function(ComponentNode) buildChild,
) {
  final label = node.props['label'] as String?;
  final bgColor = _parseColor(node.props['backgroundColor'] as String?);
  final textColor = _parseColor(node.props['textColor'] as String?);
  final isSmall = node.props['small'] as bool? ?? false;

  final child = node.children.isNotEmpty ? buildChild(node.children.first) : const SizedBox.shrink();

  if (isSmall) {
    return Badge(backgroundColor: bgColor, child: child);
  }

  return Badge(
    label: label != null
        ? Text(label, style: TextStyle(color: textColor ?? Colors.white, fontSize: 11))
        : null,
    backgroundColor: bgColor,
    child: child,
  );
}

Color? _parseColor(String? hex) {
  if (hex == null || hex.isEmpty) return null;
  final raw = hex.replaceFirst('#', '');
  if (raw.length == 6) return Color(int.parse('FF$raw', radix: 16));
  if (raw.length == 8) return Color(int.parse(raw, radix: 16));
  return null;
}
