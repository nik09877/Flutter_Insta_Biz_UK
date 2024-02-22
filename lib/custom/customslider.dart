import 'package:flutter/material.dart';

class CustomSlider extends StatefulWidget {
  final double initialValue;
  final ValueChanged<double> onChanged;

  const CustomSlider(
      {Key? key, required this.initialValue, required this.onChanged})
      : super(key: key);

  @override
  _CustomSliderState createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {
  late double _currentSliderValue;

  @override
  void initState() {
    super.initState();
    _currentSliderValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Slider Value: ${_currentSliderValue.toStringAsFixed(0)}',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18.0,
            ),
          ),
          Slider(
            value: _currentSliderValue,
            min: 0,
            max: 100,
            divisions: 100,
            activeColor: Colors.teal,
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
              });
              widget.onChanged(value);
            },
          ),
        ],
      ),
    );
  }
}
