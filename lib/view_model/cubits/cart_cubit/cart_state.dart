part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}
final class GetCartItemsLoading extends CartState {}
final class GetCartItemsSuccess extends CartState {}
