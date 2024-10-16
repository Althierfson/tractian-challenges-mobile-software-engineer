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

  List<String> hideTree = [];

  bool allHidden = false;

  PanelViewBloc({required this.fetchAssetsCompanyUsecase}) : super(PanelViewInitState()) {
    on<FetchCompanyAssetsEvent>((event, emit) async {
      emit(PanelViewLoadingState());
      await fetchAssetsCompanyUsecase(FetchAssetsCompanyParams(event.companyId))
          .then((result) => result.fold((l) => emit(PanelViewErrorState(message: l.message)), (r) {
                _hideAllTree(r);
                emit(PanelViewSuccessState(tree: r, hideTree: hideTree));
                _assetTree = r;
              }));
    });

    on<SearchAssetsEvent>((event, emit) {
      if (state is PanelViewSuccessState) {
        hideTree = [];
        allHidden = false;
        isFilteredByAssetType = false;
        isFilteredByStatus = false;
        final newTree = _searchTree(_assetTree!, event.query);
        emit(PanelViewSuccessState(tree: newTree, hideTree: hideTree));
      }
    });

    on<FilterByStatusEvent>((event, emit) {
      isFilteredByAssetType = false;
      allHidden = false;
      hideTree = [];
      if (state is PanelViewSuccessState && !isFilteredByStatus) {
        final newTree = _filterByStatus(_assetTree!, event.status);
        emit(PanelViewSuccessState(tree: newTree, hideTree: hideTree));
        isFilteredByStatus = true;
      } else {
        emit(PanelViewSuccessState(tree: _assetTree!, hideTree: hideTree));
        isFilteredByStatus = false;
      }
    });

    on<FilterByAssetTypeEvent>((event, emit) {
      isFilteredByStatus = false;
      allHidden = false;
      hideTree = [];
      if (state is PanelViewSuccessState && !isFilteredByAssetType) {
        final newTree = _filterByAssetType(_assetTree!, event.assetType);
        emit(PanelViewSuccessState(tree: newTree, hideTree: hideTree));
        isFilteredByAssetType = true;
      } else {
        emit(PanelViewSuccessState(tree: _assetTree!, hideTree: hideTree));
        isFilteredByAssetType = false;
      }
    });

    on<ShowAssetTreeEvent>((event, emit) {
      if (state is PanelViewSuccessState) {
        final newHideTree = List<String>.from(hideTree);
        if (hideTree.contains(event.assetId)) {
          newHideTree.remove(event.assetId);
        } else {
          newHideTree.add(event.assetId);
        }
        emit(PanelViewSuccessState(tree: _assetTree!, hideTree: newHideTree));
        hideTree = newHideTree;
      }
    });

    on<HideAllAssetTreeEvent>((event, emit) {
      if (state is PanelViewSuccessState) {
        if (allHidden) {
          hideTree = [];
          allHidden = false;
        } else {
          hideTree = [];
          _hideAllTree(_assetTree!);
          allHidden = true;
        }
        emit(PanelViewSuccessState(tree: _assetTree!, hideTree: hideTree));
      }
    });
  }

  AssetTree _searchTree(AssetTree tree, String query) {
    final newTree = AssetTree(tree.value);
    for (var child in tree.children) {
      final newChild = _searchTree(child, query);
      if (newChild.children.isNotEmpty ||
          newChild.name.toLowerCase().contains(query.toLowerCase())) {
        newTree.addChild(newChild);
      }
    }
    return newTree;
  }

  AssetTree _filterByStatus(AssetTree tree, String status) {
    final newTree = AssetTree(tree.value);
    for (var child in tree.children) {
      final newChild = _filterByStatus(child, status);
      if (newChild.children.isNotEmpty ||
          newChild.value is ComponentNode &&
              (newChild.value as ComponentNode).status.toLowerCase() == status.toLowerCase()) {
        newTree.addChild(newChild);
      }
    }
    return newTree;
  }

  AssetTree _filterByAssetType(AssetTree tree, String assetType) {
    final newTree = AssetTree(tree.value);
    for (var child in tree.children) {
      final newChild = _filterByAssetType(child, assetType);
      if (newChild.children.isNotEmpty ||
          newChild.value is ComponentNode &&
              (newChild.value as ComponentNode).sensorType.toLowerCase() ==
                  assetType.toLowerCase()) {
        newTree.addChild(newChild);
      }
    }
    return newTree;
  }

  void _hideAllTree(AssetTree tree) {
    hideTree.add(tree.id);
    for (var child in tree.children) {
      _hideAllTree(child);
    }
  }
}
