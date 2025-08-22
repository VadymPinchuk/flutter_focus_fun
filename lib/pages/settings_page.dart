import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_focus_fun_tv_demo/constants.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<UiExperience>(
        valueListenable: context.settingsModel.uiExperience,
        builder:
            (_, uiExperience, _) => switch (uiExperience) {
              UiExperience.tv => const _TvSettingsLayout(),
              UiExperience.mobile => const _MobileSettingsLayout(),
            },
      ),
    );
  }
}

// --- Mobile Layout ---

class _MobileSettingsLayout extends StatelessWidget {
  const _MobileSettingsLayout();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SwitchListTile(
        title: const Text('Use TV Navigation'),
        subtitle: const Text(
          'Switches between a side rail and a bottom navigation bar.',
        ),
        value: context.settingsModel.uiExperience.value.isTv,
        onChanged: (_) => context.settingsModel.toggleUiExperience(),
      ),
    );
  }
}

// --- TV Layout ---

class _TvSettingsLayout extends StatelessWidget {
  const _TvSettingsLayout();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 600 * context.textScale,
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            _TvSettingTile(
              title: 'Use TV Navigation',
              subtitle:
                  'Switches between a side rail and a bottom navigation bar',
              valueListenable: context.settingsModel.uiExperience.map(
                (exp) => exp.isTv,
              ),
              onPressed: context.settingsModel.toggleUiExperience,
              autofocus: true,
            ),
            getSpacer,
            _TvSettingTile(
              title: 'Show Focus Decoration',
              subtitle: 'Enables decoration over focused widget',
              valueListenable: context.settingsModel.useFocusDecoration,
              onPressed: context.settingsModel.toggleFocusDecoration,
            ),
            getSpacer,
            _TvSettingTile(
              title: 'Use TV Fixed Focus Scroll',
              subtitle: 'Switches to a fixed focus navigation',
              valueListenable: context.settingsModel.useTvFixedFocusController,
              onPressed: context.settingsModel.toggleTvFixedFocus,
            ),
            getSpacer,
            _TvSettingTile(
              title: 'Use TV Page Layout',
              subtitle: 'Switches to a layout optimized for TV',
              valueListenable: context.settingsModel.useTvPageLayout,
              onPressed: context.settingsModel.toggleTvPageLayout,
            ),
            getSpacer,
            _TvSettingTile(
              title: 'Use Custom Traversal Policy',
              subtitle: 'Enables custom focus traversal for better navigation',
              valueListenable: context.settingsModel.useCustomTraversalPolicy,
              onPressed: context.settingsModel.toggleTraversalPolicy,
            ),
            getSpacer,
            _TextScaleSlider(
              title: 'Content Text Scale',
              subtitle: 'Improve content visibility by changing text size',
            ),
          ],
        ),
      ),
    );
  }

  Widget get getSpacer => const SizedBox(height: 24.0);
}

class _TvSettingTile extends StatefulWidget {
  final String title;
  final String subtitle;
  final ValueNotifier<bool> valueListenable;
  final VoidCallback onPressed;
  final bool autofocus;

  const _TvSettingTile({
    required this.title,
    required this.subtitle,
    required this.valueListenable,
    required this.onPressed,
    this.autofocus = false,
  });

  @override
  State<_TvSettingTile> createState() => _TvSettingTileState();
}

class _TvSettingTileState extends State<_TvSettingTile> {
  bool _isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: widget.autofocus,
      onFocusChange: (hasFocus) {
        setState(() {
          _isFocused = hasFocus;
        });
      },
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyUpEvent) return KeyEventResult.ignored;
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          widget.onPressed();
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          widget.onPressed();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      child: InkWell(
        onTap: widget.onPressed,
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.valueListenable,
          builder: (_, value, _) {
            return AnimatedContainer(
              duration: kAnimationDuration,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: value ? Colors.white12 : Colors.transparent,
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  color: _isFocused ? Colors.white : Colors.white24,
                  width: _isFocused ? 2.0 : 1.0,
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: TextStyle(
                            fontSize: 24,
                            color: _isFocused ? Colors.white : Colors.white70,
                            fontWeight:
                                _isFocused ? FontWeight.w500 : FontWeight.w400,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 16,
                            color: _isFocused ? Colors.white : Colors.white70,
                            fontWeight:
                                _isFocused ? FontWeight.w500 : FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Visual indicator for the "on" state
                  AnimatedOpacity(
                    duration: kAnimationDuration,
                    opacity: value ? 1.0 : 0.0,
                    child: Icon(
                      Icons.check_circle,
                      color: context.colors.primary,
                      size: 32,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// A widget for adjusting the global text scale factor.
class _TextScaleSlider extends StatelessWidget {
  final String title;
  final String subtitle;

  const _TextScaleSlider({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<double>(
      valueListenable: context.settingsModel.textScaleFactor,
      builder: (_, currentTextScale, child) {
        return Column(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.w400,
                // color: _isFocused ? Colors.white : Colors.white70,
                // fontWeight:
                // _isFocused ? FontWeight.w500 : FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              spacing: 24.0,
              mainAxisSize: MainAxisSize.min,
              children: [
                _TextScalerIconButton(
                  icon: Icons.remove,
                  onPressed: () {
                    context
                        .settingsModel
                        .textScaleFactor
                        .value = (currentTextScale - 0.1).clamp(0.8, 2.0);
                  },
                ),
                Text(
                  '${(currentTextScale * 100).toStringAsFixed(0)}%',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _TextScalerIconButton(
                  icon: Icons.add,
                  onPressed: () {
                    context
                        .settingsModel
                        .textScaleFactor
                        .value = (currentTextScale + 0.1).clamp(0.8, 2.0);
                  },
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TextScalerIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _TextScalerIconButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Focus(
      canRequestFocus: false,
      descendantsAreFocusable: true,
      onKeyEvent: (FocusNode node, KeyEvent event) {
        if (event is KeyUpEvent) return KeyEventResult.ignored;
        if (event.logicalKey == LogicalKeyboardKey.enter) {
          onPressed();
          return KeyEventResult.handled;
        }
        if (event.logicalKey == LogicalKeyboardKey.numpadEnter) {
          onPressed();
          return KeyEventResult.handled;
        }
        return KeyEventResult.ignored;
      },
      onFocusChange: (hasFocus) {
        // Optionally handle focus change if needed
      },
      child: IconButton(
        icon: Icon(icon, size: 24 * context.textScale),
        color: Colors.white,
        onPressed: onPressed,
      ),
    );
  }
}

// Helper extension to map a ValueNotifier<T> to a ValueNotifier<bool>
extension<T> on ValueNotifier<T> {
  ValueNotifier<bool> map(bool Function(T) transform) {
    return _MappedValueNotifier(this, transform);
  }
}

class _MappedValueNotifier<T> extends ValueNotifier<bool> {
  final ValueNotifier<T> _source;
  final bool Function(T) _transform;

  _MappedValueNotifier(this._source, this._transform)
    : super(_transform(_source.value)) {
    _source.addListener(_listener);
  }

  void _listener() {
    value = _transform(_source.value);
  }

  @override
  void dispose() {
    _source.removeListener(_listener);
    super.dispose();
  }
}
