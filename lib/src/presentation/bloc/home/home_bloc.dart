import 'package:challenge_tractian/src/domain/entities/company/company.dart';
import 'package:challenge_tractian/src/domain/usecases/company/fetch_companies_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_states.dart';
part 'home_events.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final FetchCompaniesUsecase fetchCompaniesUsecase;
  HomeBloc({required this.fetchCompaniesUsecase}) : super(InitialHomeState()) {
    on<FetchCompaniesEvent>((event, emit) async {
      emit(FetchCompaniesLoadingState());
      await fetchCompaniesUsecase(FetchCompaniesParams()).then((value) {
        value.fold(
          (failure) async {
            emit(FetchCompaniesErrorState(message: failure.message));
          },
          (companies) async {
            emit(FetchCompaniesSuccessState(companies: companies));
          },
        );
      });
    });
  }
}
