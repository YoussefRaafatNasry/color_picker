import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'color_utils.dart';

class ColorPicker extends StatefulWidget {
  static const initialColor = Color(0xFF00FF00);
  final ValueChanged<Color>? onChange;

  const ColorPicker({super.key, this.onChange});

  @override
  State<ColorPicker> createState() => _ColorPickerState();
}

class _ColorPickerState extends State<ColorPicker> {
  late Color color;

  @override
  void initState() {
    super.initState();
    color = ColorPicker.initialColor;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          height: 24,
          width: 24,
          color: color,

        ),
        const SizedBox.square(
          dimension: 8,
        ),
        Expanded(
          child: TextFormField(
            maxLength: 6,
            initialValue: ColorPicker.initialColor.toHex(
              leadingHashSign: false,
            ),
            decoration: const InputDecoration(
              prefixText: '#',
              counterText: '',
            ),
            inputFormatters: [
              // TODO: allow all inputs and fallback to current value if invalid
              FilteringTextInputFormatter.allow(
                RegExp(r'[0-9a-fA-F]'),
              ),
            ],
            onChanged: (value) {
              if (value.length != 6) return;
              final newColor = ColorUtils.fromHex(value);

              widget.onChange?.call(newColor);
              setState(() => color = newColor);
            },
          ),
        ),
      ],
    );
  }
}
