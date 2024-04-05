part of 'home_cubit.dart';

sealed class HomeState {}

final class HomeInitial extends HomeState {}
final class GetAllPlantsLoading extends HomeState {}
final class GetAllPlantsSuccessfully extends HomeState {}
final class GetAllPlantsError extends HomeState {}
final class GetAllFertilizersLoading extends HomeState {}
final class GetAllFertilizersSuccessfully extends HomeState {}
final class GetAllFertilizersError extends HomeState {}
