import 'package:challenge_tractian/src/domain/entities/company/asset_tree.dart';
import 'package:challenge_tractian/src/domain/entities/company/component_node.dart';
import 'package:challenge_tractian/src/domain/usecases/company/fetch_assets_company_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'panel_view_states.dart';
part 'panel_view_events.dart';

class PanelViewBloc extends Bloc<PanelViewEvent, PanelViewState> {
  final FetchAssetsCompanyUsecase fetchAssetsCompanyUsecase;

  late final AssetTree? _assetTree;

  bool isFilteredByStatus = false;
  bool isFilteredByAssetType = false;

  List<String> showChildrenNode = [];

  bool allHidden = false;

  PanelViewBloc({required this.fetchAssetsCompanyUsecase}) : super(PanelViewInitState()) {
    on<FetchCompanyAssetsEvent>((event, emit) async {
      emit(PanelViewLoadingState());
      await fetchAssetsCompanyUsecase(FetchAssetsCompanyParams(event.companyId))
          .then((result) => result.fold((l) => emit(PanelViewErrorState(message: l.message)), (r) {
                // _hideAllTree(r);
                emit(PanelViewSuccessState(tree: r, showChildrenNode: showChildrenNode));
                _assetTree = r;
              }));
    });

    on<SearchAssetsEvent>((event, emit) {
      if (state is PanelViewSuccessState) {
        allHidden = false;
        isFilteredByAssetType = false;
        isFilteredByStatus = false;
        if (event.query.isNotEmpty) {
          final newTree = _searchTree(_assetTree!, event.query);
          _showAllTree(newTree);
          emit(PanelViewSuccessState(tree: newTree, showChildrenNode: showChildrenNode));
        } else {
          _hideAllTree(_assetTree!);
          emit(PanelViewSuccessState(tree: _assetTree, showChildrenNode: showChildrenNode));
        }
      }
    });

    on<FilterByStatusEvent>((event, emit) {
      isFilteredByAssetType = false;
      allHidden = false;
      if (state is PanelViewSuccessState && !isFilteredByStatus) {
        final newTree = _filterByStatus(_assetTree!, event.status);
        _showAllTree(newTree);
        emit(PanelViewSuccessState(tree: newTree, showChildrenNode: showChildrenNode));
        isFilteredByStatus = true;
      } else {
        _hideAllTree(_assetTree!);
        emit(PanelViewSuccessState(tree: _assetTree, showChildrenNode: showChildrenNode));
        isFilteredByStatus = false;
      }
    });

    on<FilterByAssetTypeEvent>((event, emit) async {
      isFilteredByStatus = false;
      allHidden = false;
      if (state is PanelViewSuccessState && !isFilteredByAssetType) {
        final newTree = _filterByAssetType(_assetTree!, event.assetType);
        _showAllTree(newTree);
        emit(PanelViewSuccessState(tree: newTree, showChildrenNode: showChildrenNode));
        isFilteredByAssetType = true;
      } else {
        _hideAllTree(_assetTree!);
        emit(PanelViewSuccessState(tree: _assetTree, showChildrenNode: showChildrenNode));
        isFilteredByAssetType = false;
      }
    });
  }

  AssetTree _searchTree(AssetTree tree, String query) {
    if (query.isEmpty) return tree;
    final normalizedQuery = query.toLowerCase();

    final filteredTree = AssetTree(tree.value);

    if (filteredTree.value.name.toLowerCase().contains(normalizedQuery)) {
      filteredTree.children = tree.children;
      return filteredTree;
    }

    for (var child in tree.children) {
      final filteredChild = _searchTree(child, query);

      final isMatchingNode = filteredChild.value.name.toLowerCase().contains(normalizedQuery);

      if (isMatchingNode || filteredChild.children.isNotEmpty) {
        filteredTree.addChild(filteredChild);
      }
    }

    return filteredTree;
  }

  AssetTree _filterByStatus(AssetTree tree, String status) {
    final normalizedStatus = status.toLowerCase();

    final filteredTree = AssetTree(tree.value);

    for (var child in tree.children) {
      final filteredChild = _filterByStatus(child, normalizedStatus);

      final isMatchingNode = filteredChild.value is ComponentNode &&
          (filteredChild.value as ComponentNode).status.toLowerCase() == normalizedStatus;

      if (isMatchingNode || filteredChild.children.isNotEmpty) {
        filteredTree.addChild(filteredChild);
      }
    }

    return filteredTree;
  }

  AssetTree _filterByAssetType(AssetTree tree, String assetType) {
    final normalizedType = assetType.toLowerCase();

    final filteredTree = AssetTree(tree.value);

    for (var child in tree.children) {
      final filteredChild = _filterByAssetType(child, assetType);

      final isMatchingNode = filteredChild.value is ComponentNode &&
          (filteredChild.value as ComponentNode).sensorType.toLowerCase() == normalizedType;

      if (isMatchingNode || filteredChild.children.isNotEmpty) {
        filteredTree.addChild(filteredChild);
      }
    }

    return filteredTree;
  }

  void _hideAllTree(AssetTree tree) {
    showChildrenNode = [];
  }

  void _showAllTree(AssetTree tree) {
    showChildrenNode.add(tree.value.id);
    for (var child in tree.children) {
      _showAllTree(child);
    }
  }
}
