import 'package:app_github_search_clean_dart/modules/search/presenter/search_bloc.dart';
import 'package:app_github_search_clean_dart/modules/search/presenter/states/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final bloc = Modular.get<SearchBloc>();

  @override
  void dispose() {
    super.dispose();
    bloc.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Github Search'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
            child: TextField(
              onChanged: bloc.add,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), labelText: "Search"),
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc,
              builder: (context, snapshot) {
                final state = bloc.state;

                if (state is SearchStart) {
                  return Center(
                    child:
                        Text('Digite alguma informação para iniciar a busca!'),
                  );
                }

                if (state is SearchError) {
                  return Center(
                    child: Text('Houve um erro na busca!'),
                  );
                }

                if (state is SearchLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final list = (state as SearchSuccess).list;

                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    return ListTile(
                      title: Text(item.login ?? ""),
                      leading: item.avatarUrl == null
                          ? Container(width: 40, height: 40)
                          : Container(
                              width: 40,
                              height: 40,
                              child: CircleAvatar(
                                backgroundImage: NetworkImage(item.avatarUrl),
                              ),
                            ),
                      subtitle: Text(item.nodeId ?? ""),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
