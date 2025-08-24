import 'package:flutter/widgets.dart';

const defaultColors = [
  Color(0xFFFF0000), // Red
  Color(0xFF00FF00), // Green
  Color(0xFF0000FF), // Blue
  Color(0xFFFFFF00), // Yellow
  Color(0xFFFF00FF), // Magenta
  Color(0xFF00FFFF), // Cyan
  Color(0xFFFFA500), // Orange
];

/// A focus debugger that listens to [FocusManager] in order to show a border around the currently focused widget.
/// Uses [Overlay] to show the border.
class FocusDebugger {
  FocusDebugger._();

  static FocusDebugger instance = FocusDebugger._();

  final _FocusOverlayController _focusOverlayController =
      _FocusOverlayController();
  FocusDebuggerConfig config = const FocusDebuggerConfig();
  bool _active = false;

  /// Sets the configuration for the focus debugger.
  /// Takes effect starting with the next focus change.
  void setConfig(FocusDebuggerConfig config) {
    this.config = config;
  }

  /// Activates the focus debugger.
  void _activate() {
    if (_active) return;
    _active = true;
    WidgetsFlutterBinding.ensureInitialized();
    FocusManager.instance.addListener(_focusChanged);
    _focusChanged();
  }

  /// Deactivates the focus debugger and removes any currently visible overlay.
  void _deactivate() {
    if (!_active) return;
    _focusOverlayController.hideOverlay();
    FocusManager.instance.removeListener(_focusChanged);
    _active = false;
  }

  void toggleIt() {
    if (_active) {
      _deactivate();
    } else {
      _activate();
    }
  }

  void _focusChanged() {
    debugDumpFocusTree();
    Future.delayed(const Duration(milliseconds: 200), () {
      final primaryFocus = FocusManager.instance.primaryFocus;
      _focusOverlayController.hideOverlay();
      if (primaryFocus?.context != null) {
        recursiveShowOverlay(primaryFocus!);
      } else {
        _focusOverlayController.hideOverlay();
      }
    });
  }

  void recursiveShowOverlay(FocusNode node) {
    final parent = node.parent;
    if (node.hasFocus && node.context != null) {
      _focusOverlayController.showOverlay(node.context!, node, config);
    }
    if (parent != null) {
      recursiveShowOverlay(parent);
    }
  }
}

class FocusDebuggerConfig {
  const FocusDebuggerConfig({
    this.colors = defaultColors,
    this.bgOpacity = 0.0,
  });

  final List<Color> colors;
  final double bgOpacity;

  Color pickColor(int index) {
    if (colors.isEmpty) {
      throw ArgumentError('Colors list cannot be empty');
    }
    return colors[index % colors.length];
  }
}

class _FocusOverlayController {
  final List<OverlayEntry> _overlayEntries = [];

  void showOverlay(
    BuildContext context,
    FocusNode node,
    FocusDebuggerConfig config,
  ) {
    final renderObject = node.context!.findRenderObject() as RenderBox;
    if (!renderObject.hasSize) {
      return;
    }

    // Calculate the position and size of the focused widget.
    final offset = renderObject.localToGlobal(Offset.zero);
    final size = renderObject.size;
    final nodeOffset = _overlayEntries.length;
    final newEntry = OverlayEntry(
      builder:
          (context) => _FocusDebuggerOverlay(
            text: '${nodeOffset + 1}. ${node.debugLabel ?? '<no label>'}',
            textOffset: nodeOffset,
            offset: offset,
            size: size,
            color: config.pickColor(nodeOffset),
            bgOpacity: config.bgOpacity,
          ),
    );
    _overlayEntries.add(newEntry);

    // Insert the OverlayEntry into the overlay.
    Overlay.maybeOf(context)?.insert(newEntry);
  }

  void hideOverlay() {
    if (_overlayEntries.isEmpty) return;
    // Remove all overlay entries.
    for (final entry in _overlayEntries) {
      if (entry.mounted) {
        entry.remove();
      }
    }
    _overlayEntries.clear();
  }
}

class _FocusDebuggerOverlay extends StatelessWidget {
  const _FocusDebuggerOverlay({
    required this.text,
    required this.textOffset,
    required this.offset,
    required this.size,
    required this.color,
    required this.bgOpacity,
  });

  final String text;
  final int textOffset;
  final Offset offset;
  final Size size;
  final Color color;
  final double bgOpacity;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      width: size.width,
      height: size.height,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x20FFFFFF),
          border: Border.all(color: color, width: 2.0),
          boxShadow: [
            BoxShadow(
              color: color.withValues(alpha: bgOpacity),
              blurRadius: 4.0,
            ),
          ],
        ),
        padding: EdgeInsets.all(4.0),
        child: Align(
          alignment: Alignment.topLeft,
          child: Transform.translate(
            offset: Offset(0, textOffset * 20.0),
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 20.0,
                inherit: false,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
