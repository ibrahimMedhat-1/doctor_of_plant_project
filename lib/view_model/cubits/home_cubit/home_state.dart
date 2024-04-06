part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class GetAllPlantsLoading extends HomeState {}
final class GetAllPlantsSuccessfully extends HomeState {}
final class GetAllPlantsError extends HomeState {}
final class GetAllFertilizersLoading extends HomeState {}
final class GetAllFertilizersSuccessfully extends HomeState {}
final class GetAllFertilizersError extends HomeState {}
final class AddPlantToCartLoading extends HomeState {}
final class PlantAddedToCart extends HomeState {}
final class PlantAddedToFav extends HomeState {}
final class removedFromFav extends HomeState {}
