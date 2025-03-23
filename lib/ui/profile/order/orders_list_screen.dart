import 'package:butcher_app/routes/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:auto_route/auto_route.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_defaults.dart';
import '../../../state/bloc/order_bloc/order_bloc.dart';
import 'order_card.dart';


@RoutePage()
class OrdersListPage extends StatefulWidget {
  const OrdersListPage({super.key});

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  String? _selectedStatus;
  
  @override
  void initState() {
    super.initState();
    context.read<OrdersBloc>().add(const FetchOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        title: const Text('My Orders'),
        leading: const AutoLeadingButton(),
      ),
      body: Column(
        children: [
          // Status filter chips
          _buildStatusFilter(),
          
          // Orders list with BLoC
          Expanded(
            child: BlocBuilder<OrdersBloc, OrdersState>(
              builder: (context, state) {
                if (state is OrdersLoading) {
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
                          'Failed to load orders',
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
                            context.read<OrdersBloc>().add(FetchOrders(status: _selectedStatus));
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
                
                if (state is OrdersLoaded) {
                  final orders = state.orders;
                  
                  if (orders.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.grey,
                            size: 80,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No orders found',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8),
                          if (_selectedStatus != null)
                            Text(
                              'You don\'t have any $_selectedStatus orders',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: () {
                              context.router.navigate(const HomeRoute());
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              foregroundColor: Colors.white,
                            ),
                            child: const Text('Start Shopping'),
                          ),
                        ],
                      ),
                    );
                  }
                  
                  return RefreshIndicator(
                    onRefresh: () async {
                      context.read<OrdersBloc>().add(FetchOrders(status: _selectedStatus));
                    },
                    child: ListView.builder(
                      padding: const EdgeInsets.all(AppDefaults.padding),
                      itemCount: orders.length,
                      itemBuilder: (context, index) {
                        final order = orders[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: OrderCard(
                            order: order,
                            onTap: () {
                              context.router.navigate(OrderDetailsRoute(orderId: order.id));
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
                
                return const Center(
                  child: Text('Start shopping to see your orders here'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusFilter() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            _buildFilterChip('All', null),
            _buildFilterChip('Pending', 'pending'),
            _buildFilterChip('Processing', 'processing'),
            _buildFilterChip('Shipped', 'shipped'),
            _buildFilterChip('Delivered', 'delivered'),
            _buildFilterChip('Cancelled', 'cancelled'),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, String? status) {
    final isSelected = _selectedStatus == status;
    
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: FilterChip(
        selected: isSelected,
        label: Text(label),
        onSelected: (selected) {
          setState(() {
            _selectedStatus = selected ? status : null;
          });
          context.read<OrdersBloc>().add(FetchOrders(status: _selectedStatus));
        },
        backgroundColor: Colors.white,
        selectedColor: AppColors.primary.withOpacity(0.1),
        checkmarkColor: AppColors.primary,
        labelStyle: TextStyle(
          color: isSelected ? AppColors.primary : Colors.black,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}