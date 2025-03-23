part of 'order_bloc.dart';
abstract class OrdersState extends Equatable {
  const OrdersState();
  
  @override
  List<Object> get props => [];
}

class OrdersInitial extends OrdersState {}

class OrdersLoading extends OrdersState {}

class OrdersLoaded extends OrdersState {
  final List<Order> orders;
  
  const OrdersLoaded({required this.orders});
  
  @override
  List<Object> get props => [orders];
}

class OrderDetailsLoading extends OrdersState {}

class OrderDetailsLoaded extends OrdersState {
  final Order order;
  
  const OrderDetailsLoaded({required this.order});
  
  @override
  List<Object> get props => [order];
}

class OrderProcessing extends OrdersState {}

class OrderTrackingLoading extends OrdersState {}

class OrderTrackingLoaded extends OrdersState {
  final OrderTracking tracking;
  
  const OrderTrackingLoaded({required this.tracking});
  
  @override
  List<Object> get props => [tracking];
}

class OrdersError extends OrdersState {
  final String message;
  
  const OrdersError({required this.message});
  
  @override
  List<Object> get props => [message];
}
