part of 'panel_view_bloc.dart';

abstract class PanelViewState extends Equatable {
  @override
  List<Object?> get props => [];
}

class PanelViewInitState extends PanelViewState {}

class PanelViewLoadingState extends PanelViewState {}

class PanelViewErrorState extends PanelViewState {
  final String message;
  PanelViewErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class PanelViewSuccessState extends PanelViewState {
  final AssetTree tree;
  final List<String> showChildrenNode;
  PanelViewSuccessState({required this.tree, required this.showChildrenNode});

  @override
  List<Object?> get props => [tree, showChildrenNode];
}