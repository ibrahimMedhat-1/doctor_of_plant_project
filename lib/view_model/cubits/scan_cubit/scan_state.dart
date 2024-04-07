part of 'scan_cubit.dart';

@immutable
sealed class ScanState {}

final class ScanInitial extends ScanState {}
final class UploadImage extends ScanState {}
final class UploadImageLoading extends ScanState {}
