import 'package:challenge_tractian/src/data/models/company/asset_model.dart';
import 'package:challenge_tractian/src/data/models/company/company_model.dart';
import 'package:challenge_tractian/src/data/models/company/location_model.dart';

abstract class CompanyDatasource {
  Future<List<CompanyModel>> fetchCompanies();
  Future<List<AssetModel>> fetchCompanyAssets(String companyId);
  Future<List<LocationModel>> fetchCompanyLocations(String companyId);
}