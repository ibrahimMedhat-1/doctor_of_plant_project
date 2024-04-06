part of 'favourites_cubit.dart';

@immutable
sealed class FavouritesState {}

final class FavouritesInitial extends FavouritesState {}
final class GetFavItemsLoading extends FavouritesState {}
final class GetFavItemsSuccess extends FavouritesState {}
final class GetFavItemsError extends FavouritesState {}
