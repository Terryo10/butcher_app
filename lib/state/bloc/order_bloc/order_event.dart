part of 'order_bloc.dart';


abstract class OrdersEvent extends Equatable {
  const OrdersEvent();

  @override
  List<Object?> get props => [];
}

class FetchOrders extends OrdersEvent {
  final String? status;
  
  const FetchOrders({this.status});
  
  @override
  List<Object?> get props => [status];
}

class FetchOrderDetails extends OrdersEvent {
  final int orderId;
  
  const FetchOrderDetails(this.orderId);
  
  @override
  List<Object> get props => [orderId];
}

class CancelOrder extends OrdersEvent {
  final int orderId;
  
  const CancelOrder(this.orderId);
  
  @override
  List<Object> get props => [orderId];
}

class FetchOrderTracking extends OrdersEvent {
  final int orderId;
  
  const FetchOrderTracking(this.orderId);
  
  @override
  List<Object> get props => [orderId];
}