import 'package:challenge_tractian/src/domain/entities/company/asset_tree.dart';
import 'package:challenge_tractian/src/domain/repositories/company/company_repository.dart';
import 'package:challenge_tractian/src/utils/failure.dart';
import 'package:challenge_tractian/src/utils/usecase.dart';
import 'package:dartz/dartz.dart';

class FetchAssetsCompanyUsecase implements Usecase<AssetTree, FetchAssetsCompanyParams> {
  final CompanyRepository repository;

  FetchAssetsCompanyUsecase({required this.repository});

  @override
  Future<Either<Failure, AssetTree>> call(FetchAssetsCompanyParams params) {
    return repository.fetchCompanyAssets(params.companyId);
  }
}

class FetchAssetsCompanyParams {
  final String companyId;

  FetchAssetsCompanyParams(this.companyId);
}
