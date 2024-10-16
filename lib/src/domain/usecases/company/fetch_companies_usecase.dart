import 'package:challenge_tractian/src/domain/entities/company/company.dart';
import 'package:challenge_tractian/src/domain/repositories/company/company_repository.dart';
import 'package:challenge_tractian/src/utils/failure.dart';
import 'package:challenge_tractian/src/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchCompaniesUsecase implements Usecase<List<Company>, FetchCompaniesParams> {
  final CompanyRepository repository;

  FetchCompaniesUsecase({required this.repository});

  @override
  Future<Either<Failure, List<Company>>> call(params) {
    return repository.fetchCompanies();
  }
}

class FetchCompaniesParams {}
