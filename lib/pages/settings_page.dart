import 'package:flutter/material.dart';
import 'package:flutter_focus_fun_tv_demo/context_extensions.dart';
import 'package:flutter_focus_fun_tv_demo/utils/ui_experience.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: context.settingsModel.uiExperience.value.isTv ? 32.0 : 16.0),
        children: [
          SizedBox(height: MediaQuery.paddingOf(context).top),
          // A ValueListenableBuilder for the TV layout switch.
          ValueListenableBuilder<UiExperience>(
            valueListenable: context.settingsModel.uiExperience,
            builder: (_, uiExperience, _) {
              return SwitchListTile(
                title: const Text('Use TV Experience'),
                subtitle: const Text(
                  'Switches between a side rail and a bottom navigation bar.',
                ),
                value: uiExperience == UiExperience.tv,
                onChanged: (_) => context.settingsModel.toggleUiExperience(),
              );
            },
          ),
          const Divider(),
          // A ValueListenableBuilder for the focus navigation switch.
          ValueListenableBuilder<bool>(
            valueListenable: context.settingsModel.useFocusToNavigate,
            builder: (context, value, child) {
              return SwitchListTile(
                title: const Text('Use Focus Navigation'),
                subtitle: const Text(
                  'Enables navigating between items with arrow keys.',
                ),
                value: value,
                onChanged: (newValue) {
                  context.settingsModel.useFocusToNavigate.value = newValue;
                },
              );
            },
          ),
          const Divider(),
          // A ValueListenableBuilder for the focus decoration switch.
          ValueListenableBuilder<bool>(
            valueListenable: context.settingsModel.useFocusDecoration,
            builder: (context, value, child) {
              return SwitchListTile(
                title: const Text('Show Focus Decoration'),
                subtitle: const Text(
                  'Visually highlights the currently focused item.',
                ),
                value: value,
                onChanged: (newValue) {
                  context.settingsModel.useFocusDecoration.value = newValue;
                },
              );
            },
          ),
          const Divider(),
          // A ValueListenableBuilder for the fixed viewport switch.
          ValueListenableBuilder<bool>(
            valueListenable: context.settingsModel.useFixedRailViewport,
            builder: (context, value, child) {
              return SwitchListTile(
                title: const Text('Use TV Viewport Layout'),
                subtitle: const Text(
                  'Shows 1.5 rails with a large preview area at the top.',
                ),
                value: value,
                onChanged: (newValue) {
                  context.settingsModel.useFixedRailViewport.value = newValue;
                },
              );
            },
          ),
          SizedBox(height: MediaQuery.paddingOf(context).bottom),
        ],
      ),
    );
  }
}
