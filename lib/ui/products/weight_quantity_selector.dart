import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/constants.dart';

class WeightQuantitySelector extends StatefulWidget {
  const WeightQuantitySelector({
    super.key,
    required this.initialWeight,
    required this.pricePerUnit,
    required this.unit,
    this.minQuantity,
    this.maxQuantity,
    this.increment,
    this.onWeightChanged,
  });

  final double initialWeight;
  final double pricePerUnit;
  final String unit;
  final double? minQuantity;
  final double? maxQuantity;
  final double? increment;
  final Function(double)? onWeightChanged;

  @override
  State<WeightQuantitySelector> createState() => _WeightQuantitySelectorState();
}

class _WeightQuantitySelectorState extends State<WeightQuantitySelector> {
  late double _weight;
  late final TextEditingController _weightController;
  double get _increment => widget.increment ?? 0.1;
  double get _minQuantity => widget.minQuantity ?? 0.1;
  double? get _maxQuantity => widget.maxQuantity;

  @override
  void initState() {
    super.initState();
    _weight = widget.initialWeight;
    _weightController = TextEditingController(text: _weight.toStringAsFixed(1));
  }

  @override
  void dispose() {
    _weightController.dispose();
    super.dispose();
  }

  void _updateWeight(double newWeight) {
    // Round to nearest increment
    double roundedWeight = (newWeight / _increment).round() * _increment;

    // Apply min/max constraints
    if (roundedWeight < _minQuantity) {
      roundedWeight = _minQuantity;
    } else if (_maxQuantity != null && roundedWeight > _maxQuantity!) {
      roundedWeight = _maxQuantity!;
    }

    setState(() {
      _weight = roundedWeight;
      _weightController.text = _weight.toStringAsFixed(1);
    });

    if (widget.onWeightChanged != null) {
      widget.onWeightChanged!(_weight);
    }
  }

  void _incrementWeight() {
    _updateWeight(_weight + _increment);
  }

  void _decrementWeight() {
    _updateWeight(_weight - _increment);
  }

  @override
  Widget build(BuildContext context) {
    // Calculate total price
    final totalPrice = _weight * widget.pricePerUnit;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Price per unit
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "\$${widget.pricePerUnit.toStringAsFixed(2)}/${widget.unit}",
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
          ],
        ),

        const SizedBox(height: 16),

        // Weight selector with label
        Row(
          children: [
            Text(
              "Weight (${widget.unit}):",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            if (_maxQuantity != null)
              Text(
                "Max: ${_maxQuantity!.toStringAsFixed(1)} ${widget.unit}",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
              ),
          ],
        ),

        const SizedBox(height: 8),

        // Weight selector controls
        Row(
          children: [
            // Decrement button
            IconButton(
              onPressed: _weight > _minQuantity ? _decrementWeight : null,
              icon: SvgPicture.asset(AppIcons.removeQuantity),
              constraints: const BoxConstraints(),
            ),

            // Weight input field
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: _weightController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    suffix: Text(widget.unit),
                  ),
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      try {
                        final double enteredWeight = double.parse(value);
                        _updateWeight(enteredWeight);
                      } catch (e) {
                        // If invalid input, reset to previous value
                        _weightController.text = _weight.toStringAsFixed(1);
                      }
                    }
                  },
                ),
              ),
            ),

            // Increment button
            IconButton(
              onPressed: _maxQuantity == null || _weight < _maxQuantity!
                  ? _incrementWeight
                  : null,
              icon: SvgPicture.asset(AppIcons.addQuantity),
              constraints: const BoxConstraints(),
            ),
          ],
        ),

        const SizedBox(height: 12),

        // Total price
        Row(
          children: [
            Text(
              "Total:",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            Text(
              "\$${totalPrice.toStringAsFixed(2)}",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ],
        ),
      ],
    );
  }
}
