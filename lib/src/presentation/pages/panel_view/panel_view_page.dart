import 'package:challenge_tractian/src/domain/entities/company/asset_tree.dart';
import 'package:challenge_tractian/src/presentation/bloc/panel_view/panel_view_bloc.dart';
import 'package:challenge_tractian/src/presentation/widgets/company/node_wideget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PanelViewPage extends StatefulWidget {
  final PanelViewBloc bloc;
  final String companyId;
  const PanelViewPage({super.key, required this.bloc, required this.companyId});

  @override
  State<PanelViewPage> createState() => _PanelViewPageState();
}

class _PanelViewPageState extends State<PanelViewPage> {
  late PanelViewBloc _bloc;

  @override
  void initState() {
    _bloc = widget.bloc;
    _bloc.add(FetchCompanyAssetsEvent(companyId: widget.companyId));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'TRACTIAN',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xff17192D),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white)),
      ),
      body: BlocBuilder(
          bloc: _bloc,
          builder: (context, state) {
            if (state is PanelViewLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PanelViewErrorState) {
              return Center(
                child: Text(state.message),
              );
            }
            if (state is PanelViewSuccessState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      decoration: const InputDecoration(
                        fillColor: Color(0xffEAEFF3),
                        filled: true,
                        prefixIcon: Icon(Icons.search, color: Color(0xff8E98A3)),
                        hintText: 'Buscar ativo ou Local',
                        hintStyle: TextStyle(color: Color(0xff8E98A3)),
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) => _bloc.add(SearchAssetsEvent(query: value)),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        _buildTextButtonIcon(
                            text: "Sensor de energia",
                            icon: Icons.bolt_outlined,
                            onPressed: () {
                              _bloc.add(FilterByAssetTypeEvent(assetType: "energy"));
                            },
                            isSelected: _bloc.isFilteredByAssetType),
                        const SizedBox(width: 8),
                        _buildTextButtonIcon(
                            text: "Crítico",
                            icon: Icons.info_outline,
                            onPressed: () {
                              _bloc.add(FilterByStatusEvent(status: "alert"));
                            },
                            isSelected: _bloc.isFilteredByStatus),
                      ],
                    ),
                  ),
                  Expanded(
                    child: _buildPanelTree(state.tree, state.showChildrenNode),
                  ),
                ],
              );
            }
            return const SizedBox();
          }),
    );
  }

  Widget _buildPanelTree(AssetTree treeAsset, List<String> showChildrenNode) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SizedBox(
        width: 600,
        child: Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: ListView.builder(
              itemCount: treeAsset.children.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return NodeWideget(
                  key: UniqueKey(),
                  asset: treeAsset.children[index],
                  showChildrenNode: showChildrenNode,
                  notFirst: false,
                );
              }),
        ),
      ),
    );
  }

  Widget _buildTextButtonIcon(
      {required String text,
      required IconData icon,
      required Function() onPressed,
      required bool isSelected}) {
    return TextButton.icon(
        style: ElevatedButton.styleFrom(
            backgroundColor: isSelected ? Colors.blue : Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            side: const BorderSide(color: Colors.grey, width: 1)),
        onPressed: onPressed,
        label: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.blue),
        ),
        icon: Icon(icon, color: isSelected ? Colors.white : Colors.blue));
  }
}
