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
  final List<String> hideTree;
  PanelViewSuccessState({required this.tree, required this.hideTree});

  @override
  List<Object?> get props => [tree, hideTree];
}