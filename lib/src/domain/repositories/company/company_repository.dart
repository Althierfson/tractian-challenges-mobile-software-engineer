import 'package:challenge_tractian/src/domain/entities/company/asset_tree.dart';
import 'package:challenge_tractian/src/domain/entities/company/company.dart';
import 'package:challenge_tractian/src/utils/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<Company>>> fetchCompanies();
  Future<Either<Failure, AssetTree>> fetchCompanyAssets(String companyId);
}