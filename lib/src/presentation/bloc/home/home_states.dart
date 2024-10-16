part of 'home_bloc.dart';

abstract class HomeState extends Equatable {}

class InitialHomeState extends HomeState {
  @override
  List<Object?> get props => [];
}

class FetchCompaniesErrorState extends HomeState {
  final String message;

  FetchCompaniesErrorState({required this.message});

  @override
  List<Object?> get props => [];
}

class FetchCompaniesSuccessState extends HomeState {
  final List<Company> companies;

  FetchCompaniesSuccessState({required this.companies});

  @override
  List<Object?> get props => [companies];
}

class FetchCompaniesLoadingState extends HomeState {
  @override
  List<Object?> get props => [];
}