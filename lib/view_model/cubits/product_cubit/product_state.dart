part of 'product_cubit.dart';

@immutable
sealed class ProductState {}

final class ProductInitial extends ProductState {}
final class PlantAddedToFav extends ProductState {}
final class removedFromFav extends ProductState {}
final class removedFromCart extends ProductState {}
final class AddToCart extends ProductState {}
