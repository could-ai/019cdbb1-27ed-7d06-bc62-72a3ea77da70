import 'package:flutter/material.dart';

class SettingsPanel extends StatelessWidget {
  final double humorLevel;
  final double honestyLevel;
  final String currentMode;
  final ValueChanged<double> onHumorChanged;
  final ValueChanged<double> onHonestyChanged;
  final ValueChanged<String> onModeChanged;

  const SettingsPanel({
    super.key,
    required this.humorLevel,
    required this.honestyLevel,
    required this.currentMode,
    required this.onHumorChanged,
    required this.onHonestyChanged,
    required this.onModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'SYSTEM PARAMETERS',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 2,
              color: Colors.amber,
            ),
          ),
          const SizedBox(height: 24),
          
          // Humor Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('HUMOR'),
              Text('${humorLevel.toInt()}%'),
            ],
          ),
          Slider(
            value: humorLevel,
            min: 0,
            max: 100,
            divisions: 10,
            activeColor: Colors.amber,
            onChanged: onHumorChanged,
          ),
          
          const SizedBox(height: 16),
          
          // Honesty Slider
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('HONESTY'),
              Text('${honestyLevel.toInt()}%'),
            ],
          ),
          Slider(
            value: honestyLevel,
            min: 0,
            max: 100,
            divisions: 10,
            activeColor: Colors.amber,
            onChanged: onHonestyChanged,
          ),

          const SizedBox(height: 24),
          
          // Mode Selector
          const Text('OPERATING MODE'),
          const SizedBox(height: 8),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'General', label: Text('General')),
              ButtonSegment(value: 'Study', label: Text('Study')),
              ButtonSegment(value: 'Mission', label: Text('Mission')),
            ],
            selected: {currentMode},
            onSelectionChanged: (Set<String> newSelection) {
              onModeChanged(newSelection.first);
            },
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.amber;
                  }
                  return Colors.transparent;
                },
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.selected)) {
                    return Colors.black;
                  }
                  return Colors.white;
                },
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
