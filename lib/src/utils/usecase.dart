import 'package:challenge_tractian/src/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class Usecase<R, P> {
  Future<Either<Failure, R>> call(P params);
}
