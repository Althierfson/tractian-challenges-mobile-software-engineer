part of 'panel_view_bloc.dart';

abstract class PanelViewEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCompanyAssetsEvent extends PanelViewEvent {
  final String companyId;
  FetchCompanyAssetsEvent({required this.companyId});
}

class SearchAssetsEvent extends PanelViewEvent {
  final String query;
  SearchAssetsEvent({required this.query});
}

class FilterByStatusEvent extends PanelViewEvent {
  final String status;
  FilterByStatusEvent({required this.status});
}

class FilterByAssetTypeEvent extends PanelViewEvent {
  final String assetType;
  FilterByAssetTypeEvent({required this.assetType});
}

class ShowAssetTreeEvent extends PanelViewEvent {
  final String assetId;
  ShowAssetTreeEvent({required this.assetId});
}

class HideAllAssetTreeEvent extends PanelViewEvent {}
