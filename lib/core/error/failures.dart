import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
abstract class Failure with _$Failure {
  const factory Failure.serverFailure({required String message}) =
      ServerFailure;
  const factory Failure.networkFailure({required String message}) =
      NetWorkFailure;
  const factory Failure.userNotFoundFailure({required String message}) =
      UserNotFoundFailure;
  const factory Failure.emailAlreadyInUseFailure({required String message}) =
      EmailAlreadyInUseFailure;
  const factory Failure.weakPasswordFailure({required String message}) =
      WeakPasswordFailure;
  const factory Failure.wrongPasswordFailure({required String message}) =
      WrongPasswordFailure;
  const factory Failure.unknownFailure({required String message}) =
      UnknownFailure;
}
