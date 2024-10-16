import 'package:challenge_tractian/src/presentation/bloc/home/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  final HomeBloc homeBloc;
  const HomePage({super.key, required this.homeBloc});

  @override
  Widget build(BuildContext context) {
    homeBloc.add(FetchCompaniesEvent());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TRACTIAN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff17192D),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state is FetchCompaniesLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchCompaniesErrorState) {
            return Center(
              child: Text(state.message),
            );
          } else if (state is FetchCompaniesSuccessState) {
            return ListView.builder(
              itemCount: state.companies.length,
              itemBuilder: (context, index) {
                final company = state.companies[index];
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5.0), color: const Color(0xff2188FF)),
                    child: ListTile(
                      onTap: () {
                        GoRouter.of(context)
                            .pushNamed('company-panel', pathParameters: {'companyId': company.id});
                      },
                      leading: const Icon(
                        Icons.business,
                        color: Colors.white,
                      ),
                      title: Text(
                        "${company.name} Unit",
                        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          return Container();
        },
      ),
    );
  }
}
