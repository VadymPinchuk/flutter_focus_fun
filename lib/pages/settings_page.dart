import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/model/tv_settings_model.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';
import 'package:provider/provider.dart';

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
    final settingsModel = context.watch<TvSettingsModel>();
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        SwitchListTile(
          title: const Text('Use TV Experience'),
          subtitle: const Text(
            'Switches between a side rail and a bottom navigation bar.',
          ),
          value: true, // Always true in this layout
          onChanged: (_) => context.settingsModel.toggleUiExperience(),
        ),
        const Divider(),
        ValueListenableBuilder<bool>(
          valueListenable: settingsModel.useFocusToNavigate,
          builder: (context, value, child) {
            return SwitchListTile(
              title: const Text('Use Focus Navigation'),
              subtitle: const Text(
                'Enables navigating between items with arrow keys.',
              ),
              value: value,
              onChanged: (newValue) {
                settingsModel.useFocusToNavigate.value = newValue;
              },
            );
          },
        ),
        const Divider(),
        ValueListenableBuilder<bool>(
          valueListenable: settingsModel.useFocusDecoration,
          builder: (context, value, child) {
            return SwitchListTile(
              title: const Text('Show Focus Decoration'),
              subtitle: const Text(
                'Visually highlights the currently focused item.',
              ),
              value: value,
              onChanged: (newValue) {
                settingsModel.useFocusDecoration.value = newValue;
              },
            );
          },
        ),
        const Divider(),
        ValueListenableBuilder<bool>(
          valueListenable: settingsModel.useFixedRailViewport,
          builder: (context, value, child) {
            return SwitchListTile(
              title: const Text('Use TV Viewport Layout'),
              subtitle: const Text(
                'Shows 1.5 rails with a large preview area at the top.',
              ),
              value: value,
              onChanged: (newValue) {
                settingsModel.useFixedRailViewport.value = newValue;
              },
            );
          },
        ),
      ],
    );
  }
}

// --- TV Layout ---

class _TvSettingsLayout extends StatelessWidget {
  const _TvSettingsLayout();

  @override
  Widget build(BuildContext context) {
    final settingsModel = context.watch<TvSettingsModel>();
    return Center(
      child: SizedBox(
        width: 600, // Constrain the width for a better look on large screens
        child: ListView(
          padding: const EdgeInsets.all(32.0),
          children: [
            _TvSettingTile(
              title: 'Use TV Experience',
              subtitle:
                  'Switches between a side rail and a bottom navigation bar.',
              valueListenable: settingsModel.uiExperience.map(
                (exp) => exp == UiExperience.tv,
              ),
              onPressed: () => context.settingsModel.toggleUiExperience(),
              autofocus: true,
            ),
            const SizedBox(height: 16),
            _TvSettingTile(
              title: 'Use Focus Navigation',
              subtitle: 'Enables navigating between items with arrow keys.',
              valueListenable: settingsModel.useFocusToNavigate,
              onPressed:
                  () =>
                      settingsModel.useFocusToNavigate.value =
                          !settingsModel.useFocusToNavigate.value,
            ),
            const SizedBox(height: 16),
            _TvSettingTile(
              title: 'Show Focus Decoration',
              subtitle: 'Visually highlights the currently focused item.',
              valueListenable: settingsModel.useFocusDecoration,
              onPressed:
                  () =>
                      settingsModel.useFocusDecoration.value =
                          !settingsModel.useFocusDecoration.value,
            ),
            const SizedBox(height: 16),
            _TvSettingTile(
              title: 'Use TV Viewport Layout',
              subtitle: 'Shows 1.5 rails with a large preview area at the top.',
              valueListenable: settingsModel.useFixedRailViewport,
              onPressed:
                  () =>
                      settingsModel.useFixedRailViewport.value =
                          !settingsModel.useFixedRailViewport.value,
            ),
          ],
        ),
      ),
    );
  }
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
      child: InkWell(
        onTap: widget.onPressed,
        child: ValueListenableBuilder<bool>(
          valueListenable: widget.valueListenable,
          builder: (context, value, child) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
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
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.subtitle,
                          style: const TextStyle(color: Colors.white70),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Visual indicator for the "on" state
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 200),
                    opacity: value ? 1.0 : 0.0,
                    child: const Icon(Icons.check_circle, color: Colors.white),
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
