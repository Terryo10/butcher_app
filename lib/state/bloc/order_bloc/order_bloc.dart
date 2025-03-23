import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/order_model.dart';
import '../../../repositories/orders_repository/order_repository.dart';

part 'order_event.dart';
part 'order_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  final OrderRepository orderRepository;
  
  OrdersBloc({required this.orderRepository}) : super(OrdersInitial()) {
    on<FetchOrders>((event, emit) async {
      emit(OrdersLoading());
      try {
        final orders = await orderRepository.getOrders(status: event.status);
        emit(OrdersLoaded(orders: orders));
      } catch (e) {
        emit(OrdersError(message: e.toString()));
      }
    });
    
    on<FetchOrderDetails>((event, emit) async {
      emit(OrderDetailsLoading());
      try {
        final order = await orderRepository.getOrder(event.orderId);
        emit(OrderDetailsLoaded(order: order));
      } catch (e) {
        emit(OrdersError(message: e.toString()));
      }
    });
    
    on<CancelOrder>((event, emit) async {
      if (state is OrderDetailsLoaded) {
        final currentState = state as OrderDetailsLoaded;
        emit(OrderProcessing());
        
        try {
          final updatedOrder = await orderRepository.cancelOrder(event.orderId);
          emit(OrderDetailsLoaded(order: updatedOrder));
        } catch (e) {
          emit(OrdersError(message: e.toString()));
          // Revert to previous state
          emit(currentState);
        }
      }
    });
    
    on<FetchOrderTracking>((event, emit) async {
      emit(OrderTrackingLoading());
      try {
        final tracking = await orderRepository.getOrderTracking(event.orderId);
        emit(OrderTrackingLoaded(tracking: tracking));
      } catch (e) {
        emit(OrdersError(message: e.toString()));
      }
    });
  }
}