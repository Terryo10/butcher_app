import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_defaults.dart';

class CouponCodeField extends StatefulWidget {
  const CouponCodeField({
    super.key,
    this.appliedCoupon,
    required this.onApply,
    required this.onRemove,
  });

  final String? appliedCoupon;
  final Function(String) onApply;
  final VoidCallback onRemove;

  @override
  State<CouponCodeField> createState() => _CouponCodeFieldState();
}

class _CouponCodeFieldState extends State<CouponCodeField> {
  late TextEditingController controller;
  bool isFilled = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.appliedCoupon);
    isFilled = widget.appliedCoupon != null && widget.appliedCoupon!.isNotEmpty;
  }

  @override
  void didUpdateWidget(CouponCodeField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.appliedCoupon != oldWidget.appliedCoupon) {
      controller.text = widget.appliedCoupon ?? '';
      isFilled = widget.appliedCoupon != null && widget.appliedCoupon!.isNotEmpty;
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void onChange(String? text) {
    if (text != null && text.isNotEmpty) {
      setState(() {
        isFilled = true;
      });
    } else {
      setState(() {
        isFilled = false;
      });
    }
  }

  void _applyCoupon() {
    if (isFilled && controller.text.isNotEmpty) {
      widget.onApply(controller.text);
      FocusScope.of(context).unfocus();
    }
  }

  void _removeCoupon() {
    controller.clear();
    setState(() {
      isFilled = false;
    });
    widget.onRemove();
  }

  @override
  Widget build(BuildContext context) {
    final bool hasCoupon = widget.appliedCoupon != null && widget.appliedCoupon!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.all(AppDefaults.padding),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              hasCoupon ? 'Applied Coupon' : 'Add Coupon',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.bold, color: Colors.black),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(
                    labelText: hasCoupon ? 'Applied Voucher Code' : 'Enter Voucher Code',
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDefaults.padding,
                    ),
                    suffixIcon: hasCoupon
                        ? const IconButton(
                            icon:  Icon(Icons.check_circle, color: Colors.green),
                            onPressed: null,
                          )
                        : null,
                    enabled: !hasCoupon, // Disable editing if coupon is applied
                  ),
                  onChanged: onChange,
                  controller: controller,
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: ElevatedButton(
                  onPressed: hasCoupon ? _removeCoupon : (isFilled ? _applyCoupon : null),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: hasCoupon 
                        ? Colors.red
                        : (isFilled ? null : AppColors.placeholder),
                    backgroundColor: hasCoupon
                        ? Colors.red.withValues(alpha: 0.1)
                        : (isFilled ? null : Colors.grey.withValues(alpha:0.3)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(hasCoupon ? 'Remove' : 'Apply'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}