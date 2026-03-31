import 'package:flutter/material.dart';

import 'json_syntax_highlighter.dart';

/// Controller that overrides [buildTextSpan] to return syntax-highlighted
/// spans directly, keeping native cursor, selection and scroll behaviour.
class _HighlightingController extends TextEditingController {
  _HighlightingController({super.text});

  @override
  TextSpan buildTextSpan({
    required BuildContext context,
    TextStyle? style,
    required bool withComposing,
  }) {
    final spans = JsonSyntaxHighlighter.highlight(text);
    return TextSpan(style: style, children: spans);
  }
}

/// Dark-themed JSON editor with real-time syntax highlighting and line numbers.
class JsonEditorPanel extends StatefulWidget {
  final TextEditingController controller;

  const JsonEditorPanel({super.key, required this.controller});

  @override
  State<JsonEditorPanel> createState() => _JsonEditorPanelState();
}

class _JsonEditorPanelState extends State<JsonEditorPanel> {
  late final _HighlightingController _highlightController;

  @override
  void initState() {
    super.initState();
    _highlightController = _HighlightingController(text: widget.controller.text);

    widget.controller.addListener(_syncToHighlight);
    _highlightController.addListener(_syncFromHighlight);
  }

  /// Keep the highlighting controller in sync when the parent controller changes
  /// (e.g. format JSON, load screen, clear).
  void _syncToHighlight() {
    if (_updatingFrom) return;
    _updatingTo = true;
    if (_highlightController.text != widget.controller.text) {
      _highlightController.text = widget.controller.text;
    }
    _updatingTo = false;
  }

  /// Push edits from the highlighting controller back to the parent.
  void _syncFromHighlight() {
    if (_updatingTo) return;
    _updatingFrom = true;
    if (widget.controller.text != _highlightController.text) {
      widget.controller.text = _highlightController.text;
    }
    _updatingFrom = false;
  }

  bool _updatingTo = false;
  bool _updatingFrom = false;

  @override
  void dispose() {
    widget.controller.removeListener(_syncToHighlight);
    _highlightController.removeListener(_syncFromHighlight);
    _highlightController.dispose();
    super.dispose();
  }

  static const _monoStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    color: Color(0xFFD4D4D4),
    height: 1.6,
  );

  static const _lineNumStyle = TextStyle(
    fontFamily: 'monospace',
    fontSize: 13,
    color: Color(0xFF858585),
    height: 1.6,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E1E1E),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Line numbers gutter
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: _highlightController,
            builder: (_, value, _) {
              final lineCount = '\n'.allMatches(value.text).length + 1;
              return Container(
                width: 48,
                padding: const EdgeInsets.only(top: 16, right: 8),
                alignment: Alignment.topRight,
                child: Text(
                  List.generate(lineCount, (i) => '${i + 1}').join('\n'),
                  style: _lineNumStyle,
                  textAlign: TextAlign.right,
                ),
              );
            },
          ),
          Container(width: 1, color: const Color(0xFF333333)),
          // Editor
          Expanded(
            child: TextField(
              controller: _highlightController,
              maxLines: null,
              expands: true,
              textAlignVertical: TextAlignVertical.top,
              style: _monoStyle,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.all(16),
                border: InputBorder.none,
                hintText: 'Paste or type your JSON contract here...',
                hintStyle: TextStyle(color: Color(0xFF555555)),
              ),
              cursorColor: const Color(0xFF569CD6),
            ),
          ),
        ],
      ),
    );
  }
}
