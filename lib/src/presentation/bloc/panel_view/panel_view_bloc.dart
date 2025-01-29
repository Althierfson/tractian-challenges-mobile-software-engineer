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
        _hideAllTree(_assetTree!);
        emit(PanelViewSuccessState(tree: _assetTree, hideTree: hideTree));
        isFilteredByStatus = false;
      }
    });

    on<FilterByAssetTypeEvent>((event, emit) async {
      isFilteredByStatus = false;
      allHidden = false;
      hideTree = [];
      if (state is PanelViewSuccessState && !isFilteredByAssetType) {
        final newTree = _filterByAssetType({'tree': _assetTree, 'assetType': event.assetType});
        emit(PanelViewSuccessState(tree: newTree, hideTree: hideTree));
        isFilteredByAssetType = true;
      } else {
        _hideAllTree(_assetTree!);
        emit(PanelViewSuccessState(tree: _assetTree, hideTree: hideTree));
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
  }

  AssetTree _searchTree(AssetTree tree, String query) {
    final normalizedQuery = query.toLowerCase();

    final filteredTree = AssetTree(tree.value);

    for (var child in tree.children) {
      final filteredChild = _searchTree(child, query);

      final isMatchingNode = filteredChild.value is ComponentNode &&
          (filteredChild.value as ComponentNode).name.toLowerCase().contains(normalizedQuery);

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

  AssetTree _filterByAssetType(Map<String, dynamic> args) {
    AssetTree tree = args['tree'];
    String assetType = args['assetType'];

    final normalizedType = assetType.toLowerCase();

    final filteredTree = AssetTree(tree.value);

    for (var child in tree.children) {
      final filteredChild = _filterByAssetType({'tree': child, 'assetType': assetType});

      final isMatchingNode = filteredChild.value is ComponentNode &&
          (filteredChild.value as ComponentNode).sensorType.toLowerCase() == normalizedType;

      if (isMatchingNode || filteredChild.children.isNotEmpty) {
        filteredTree.addChild(filteredChild);
      }
    }

    return filteredTree;
  }

  void _hideAllTree(AssetTree tree) {
    hideTree.add(tree.id);
    for (var child in tree.children) {
      _hideAllTree(child);
    }
  }
}
