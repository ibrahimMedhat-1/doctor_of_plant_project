part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class ChangeInformation extends ProfileState {}
final class ChangeImage extends ProfileState {}
final class GetMYData extends ProfileState {}
final class ChangeInformationLoading extends ProfileState {}
final class ChangeImageLoading extends ProfileState {}
