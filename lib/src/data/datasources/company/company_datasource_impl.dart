import 'package:challenge_tractian/core/client/api_client.dart';
import 'package:challenge_tractian/core/client/api_response.dart';
import 'package:challenge_tractian/src/data/datasources/company/company_datasource.dart';
import 'package:challenge_tractian/src/data/models/company/asset_model.dart';
import 'package:challenge_tractian/src/data/models/company/company_model.dart';
import 'package:challenge_tractian/src/data/models/company/location_model.dart';
import 'package:challenge_tractian/src/utils/failure.dart';
import 'package:flutter/foundation.dart';

class CompanyDatasourceImpl implements CompanyDatasource {
  final ApiClient client;

  CompanyDatasourceImpl({required this.client});

  @override
  Future<List<CompanyModel>> fetchCompanies() async {
    late ApiResponse response;
    try {
      response = await client.get("/companies");
    } catch (error) {
      if (kDebugMode) {
        debugPrint("Exception CompanyDatasourceImpl.fetchCompanies");
        debugPrint(error.toString());
      }
      throw ServerFailure();
    }

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;
      return data.map((e) => CompanyModel.fromJson(e)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<AssetModel>> fetchCompanyAssets(String companyId) async {
    late ApiResponse response;
    try {
      response = await client.get("/companies/$companyId/assets");
    } catch (error) {
      if (kDebugMode) {
        debugPrint("Exception CompanyDatasourceImpl.fetchCompanyAssets");
        debugPrint(error.toString());
      }
      throw ServerFailure();
    }

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;
      return data.map((e) => AssetModel.fromJson(e)).toList();
    } else {
      throw ServerFailure();
    }
  }

  @override
  Future<List<LocationModel>> fetchCompanyLocations(String companyId) async {
    late ApiResponse response;
    try {
      response = await client.get("/companies/$companyId/locations");
    } catch (error) {
      if (kDebugMode) {
        debugPrint("Exception CompanyDatasourceImpl.fetchCompanyAssets");
        debugPrint(error.toString());
      }
      throw ServerFailure();
    }

    if (response.statusCode == 200) {
      final List<dynamic> data = response.body;
      return data.map((e) => LocationModel.fromJson(e)).toList();
    } else {
      throw ServerFailure();
    }
  }
}
