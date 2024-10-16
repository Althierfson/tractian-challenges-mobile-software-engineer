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

      // build tree
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
    AssetTree tree = AssetTree(BaseNode(id: "0", name: "Root"));

    // Usar uma lista de nós que foram adicionados para controle.
    Set<String> addedNodeIds = {"0"}; // Adicionar o ID do nó raiz.

    // Continuar enquanto ainda há localizações que não foram adicionadas.
    while (locations.isNotEmpty) {
      bool added = false;

      for (int i = 0; i < locations.length; i++) {
        var location = locations[i];

        // Verificar se o pai do item já foi adicionado ou se ele não tem pai (parentId == null).
        if (location.parentId == null || addedNodeIds.contains(location.parentId)) {
          // Tentar adicionar a localização.
          _addLocationOnTree(tree, location);
          // Marcar o ID como adicionado.
          addedNodeIds.add(location.id);
          // Remover a localização da lista.
          locations.removeAt(i);
          added = true;
          break; // Interromper o loop for para tentar o próximo item.
        }
      }

      // Se nenhum item foi adicionado na iteração, significa que há uma dependência circular ou o pai ainda não foi processado.
      if (!added) {
        throw Exception('Circular dependency detected or parent not processed.');
      }
    }

    // Adicionar os ativos após as localizações.
    for (var asset in assets) {
      _addAssetToTree(tree, asset);
    }

    return tree;
  }

  void _addLocationOnTree(AssetTree tree, LocationModel location) {
    if (location.parentId == tree.value.id || location.parentId == null) {
      tree.addChild(AssetTree(location.toLocationNode()));
    } else {
      for (var child in tree.children) {
        _addLocationOnTree(child, location);
      }
    }
  }

  void _addAssetToTree(AssetTree tree, AssetModel asset) {
    if (asset.locationId == tree.value.id || asset.locationId == null) {
      tree.addChild(AssetTree(asset.toNode()));
    } else if (asset.parentId == tree.value.id) {
      tree.addChild(AssetTree(asset.toNode()));
    } else {
      for (var child in tree.children) {
        _addAssetToTree(child, asset);
      }
    }
  }
}
