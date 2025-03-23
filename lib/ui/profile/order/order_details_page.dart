import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_defaults.dart';
import '../../../models/order_model.dart';
import '../../../routes/router.gr.dart';
import '../../../state/bloc/order_bloc/order_bloc.dart';
import 'order_product_item.dart';
import 'order_status_chip.dart';

@RoutePage()
class OrderDetailsPage extends StatefulWidget {
  final int orderId;

  const OrderDetailsPage({
    super.key,
    @PathParam('orderId') required this.orderId,
  });

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(FetchOrderDetails(widget.orderId));
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Details'),
        leading: const AutoLeadingButton(),
        actions: [
          BlocBuilder<OrdersBloc, OrdersState>(
            builder: (context, state) {
              if (state is OrderDetailsLoaded) {
                final order = state.order;
                if (order.status.toLowerCase() == 'pending') {
                  return IconButton(
                    icon: const Icon(Icons.cancel_outlined),
                    tooltip: 'Cancel Order',
                    onPressed: () => _showCancelDialog(context, order),
                  );
                }
              }
              return const SizedBox();
            },
          ),
        ],
      ),
      body: BlocBuilder<OrdersBloc, OrdersState>(
        builder: (context, state) {
          if (state is OrderDetailsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is OrdersError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 60,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load order details',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context
                          .read<OrdersBloc>()
                          .add(FetchOrderDetails(widget.orderId));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Try Again'),
                  ),
                ],
              ),
            );
          }

          if (state is OrderDetailsLoaded) {
            final order = state.order;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOrderHeader(order),
                    const SizedBox(height: 24),
                    _buildOrderItems(order),
                    const SizedBox(height: 24),
                    if (order.address != null)
                      _buildAddressCard(order.address!),
                    const SizedBox(height: 24),
                    _buildOrderSummary(order),

                    // Action buttons
                    if (order.status.toLowerCase() == 'shipped' ||
                        order.status.toLowerCase() == 'delivered')
                      _buildTrackingButton(order),

                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          }

          return const Center(child: Text('Loading order details...'));
        },
      ),
    );
  }

  Widget _buildOrderHeader(Order order) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order #${order.orderNumber}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 5),
            OrderStatusChip(status: order.status),
            const SizedBox(height: 12),
            _buildInfoRow('Date', _formatDate(order.createdAt)),
            const SizedBox(height: 8),
            _buildInfoRow('Items',
                '${order.items.length} ${order.items.length == 1 ? 'item' : 'items'}'),
            const SizedBox(height: 8),
            if (order.paymentType != null) ...[
              _buildInfoRow(
                  'Payment Method', _formatPaymentMethod(order.paymentType!)),
              const SizedBox(height: 8),
            ],
            _buildInfoRow('Payment Status', order.paymentStatus,
                isStatus: true, statusType: 'payment'),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItems(Order order) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: order.items.length,
              separatorBuilder: (context, index) => const Divider(),
              itemBuilder: (context, index) {
                final item = order.items[index];
                return OrderProductItem(item: item);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressCard(Address address) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Address',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Colors.grey,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        address.addressLine1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (address.addressLine2 != null &&
                          address.addressLine2!.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(address.addressLine2!),
                      ],
                      const SizedBox(height: 4),
                      Text(
                          '${address.city}, ${address.state ?? ''} ${address.postalCode}'),
                      const SizedBox(height: 4),
                      Text(address.country),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderSummary(Order order) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Order Summary',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            _buildSummaryRow(
                'Subtotal', '\$${order.subtotal.toStringAsFixed(2)}'),
            if (order.discountAmount != null && order.discountAmount! > 0) ...[
              const SizedBox(height: 8),
              _buildSummaryRow(
                'Discount${order.couponCode != null ? ' (${order.couponCode})' : ''}',
                '-\$${order.discountAmount!.toStringAsFixed(2)}',
                valueColor: Colors.red,
              ),
            ],
            const SizedBox(height: 8),
            _buildSummaryRow('Shipping',
                '\$${order.shippingAmount?.toStringAsFixed(2) ?? '0.00'}'),
            const SizedBox(height: 8),
            _buildSummaryRow(
                'Tax', '\$${order.taxAmount?.toStringAsFixed(2) ?? '0.00'}'),
            const Divider(height: 24),
            _buildSummaryRow('Total', '\$${order.total.toStringAsFixed(2)}',
                isBold: true),
          ],
        ),
      ),
    );
  }

  Widget _buildTrackingButton(Order order) {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            context.navigateTo(
              OrderTrackingRoute(
                order: order,
              ),
            );
          },
          icon: const Icon(Icons.local_shipping_outlined),
          label: const Text('Track Order'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value,
      {bool isStatus = false, String? statusType}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        isStatus
            ? _buildStatusText(value, type: statusType)
            : Text(
                value,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
      ],
    );
  }

  Widget _buildStatusText(String status, {String? type}) {
    Color statusColor;

    if (type == 'payment') {
      switch (status.toLowerCase()) {
        case 'paid':
          statusColor = Colors.green;
          break;
        case 'pending':
          statusColor = Colors.orange;
          break;
        case 'failed':
          statusColor = Colors.red;
          break;
        case 'refunded':
          statusColor = Colors.blue;
          break;
        default:
          statusColor = Colors.grey;
      }
    } else {
      switch (status.toLowerCase()) {
        case 'pending':
          statusColor = Colors.orange;
          break;
        case 'processing':
          statusColor = Colors.blue;
          break;
        case 'shipped':
          statusColor = Colors.indigo;
          break;
        case 'delivered':
          statusColor = Colors.green;
          break;
        case 'cancelled':
          statusColor = Colors.red;
          break;
        default:
          statusColor = Colors.grey;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: statusColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: statusColor,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value,
      {bool isBold = false, Color? valueColor}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 14,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: valueColor ?? Colors.black,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontSize: isBold ? 16 : 14,
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  String _formatPaymentMethod(String paymentType) {
    switch (paymentType.toLowerCase()) {
      case 'card':
        return 'Credit Card';
      case 'paypal':
        return 'PayPal';
      case 'cashondelivery':
        return 'Cash on Delivery';
      default:
        return paymentType;
    }
  }

  void _showCancelDialog(BuildContext context, Order order) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Order'),
        content: const Text(
          'Are you sure you want to cancel this order? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('NO'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<OrdersBloc>().add(CancelOrder(order.id));

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Order cancellation in progress...'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('YES, CANCEL'),
          ),
        ],
      ),
    );
  }
}
