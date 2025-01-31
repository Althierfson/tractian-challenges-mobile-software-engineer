import 'package:challenge_tractian/src/data/datasources/company/company_datasource.dart';
import 'package:challenge_tractian/src/data/models/company/asset_model.dart';
import 'package:challenge_tractian/src/data/models/company/location_model.dart';
import 'package:challenge_tractian/src/domain/entities/company/asset_tree.dart';
import 'package:challenge_tractian/src/domain/entities/company/base_node.dart';
import 'package:challenge_tractian/src/domain/entities/company/company.dart';
import 'package:challenge_tractian/src/domain/repositories/company/company_repository.dart';
import 'package:challenge_tractian/src/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

class CompanyRepositoryImpl implements CompanyRepository {
  final CompanyDatasource datasource;

  CompanyRepositoryImpl({required this.datasource});

  @override
  Future<Either<Failure, List<Company>>> fetchCompanies() async {
    try {
      final companies = await datasource.fetchCompanies();
      return Right(companies.map((companie) => companie.toEntity()).toList());
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      if (kDebugMode) {
        debugPrint("Exception CompanyRepositoryImpl.fetchCompanies");
        debugPrint(error.toString());
      }
      return Left(UnexpectedFailure());
    }
  }

  @override
  Future<Either<Failure, AssetTree>> fetchCompanyAssets(String companyId) async {
    try {
      final locations = await datasource.fetchCompanyLocations(companyId);
      final assets = await datasource.fetchCompanyAssets(companyId);

      final tree = _buildTree(locations, assets);
      return Right(tree);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (error) {
      if (kDebugMode) {
        debugPrint("Exception CompanyRepositoryImpl.fetchCompanyAssets");
        debugPrint(error.toString());
      }
      return Left(UnexpectedFailure());
    }
  }

  AssetTree _buildTree(List<LocationModel> locations, List<AssetModel> assets) {
    Map<String, AssetTree> nodeMap = {};

    AssetTree root = AssetTree(BaseNode(id: "0", name: "Root"));
    nodeMap["0"] = root;

    for (var location in locations) {
      nodeMap[location.id] = AssetTree(location.toLocationNode());
    }

    for (var location in locations) {
      if (location.parentId != null && nodeMap.containsKey(location.parentId)) {
        nodeMap[location.parentId]!.addChild(nodeMap[location.id]!);
      } else {
        root.addChild(nodeMap[location.id]!);
      }
    }

    for (var asset in assets) {
      nodeMap[asset.id] = AssetTree(asset.toNode());
    }

    for (var asset in assets) {
      if (asset.locationId != null && nodeMap.containsKey(asset.locationId)) {
        nodeMap[asset.locationId]!.addChild(nodeMap[asset.id]!);
      } else if (asset.parentId != null && nodeMap.containsKey(asset.parentId)) {
        nodeMap[asset.parentId]!.addChild(nodeMap[asset.id]!);
      } else {
        root.addChild(nodeMap[asset.id]!);
      }
    }

    return root;
  }
}
