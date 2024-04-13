part of 'scan_cubit.dart';

@immutable
sealed class ScanState {}

final class ScanInitial extends ScanState {}

final class UploadImage extends ScanState {}

final class UploadImageLoading extends ScanState {}

final class LoadModelSuccess extends ScanState {}

final class LoadModelError extends ScanState {}

final class ClassifySuccess extends ScanState {}

final class ClassifyError extends ScanState {}

final class DetectPlantDisease extends ScanState {}
